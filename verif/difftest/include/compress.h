#ifndef COMPRESS_H
#define COMPRESS_H
#include <iostream>
#include <fstream>
#include <string>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <cstring>
#include <zlib.h>

class MMapCompressor {
public:
    // 压缩并保存mmap内存数据到文件
    static bool compressAndSave(const void* mapped_data, size_t data_size, 
                               const std::string& output_filename, int compression_level = Z_DEFAULT_COMPRESSION) {
        if (!mapped_data || data_size == 0) {
            std::cerr << "错误: 无效的输入数据" << std::endl;
            return false;
        }

        // 计算压缩后的最大可能大小
        uLongf compressed_size = compressBound(data_size);
        std::vector<Bytef> compressed_buffer(compressed_size);

        // 使用zlib进行压缩
        int result = compress2(compressed_buffer.data(), &compressed_size,
                              reinterpret_cast<const Bytef*>(mapped_data), data_size,
                              compression_level);

        if (result != Z_OK) {
            std::cerr << "压缩失败，错误代码: " << result << std::endl;
            return false;
        }

        // 写入文件
        std::ofstream out_file(output_filename, std::ios::binary);
        if (!out_file) {
            std::cerr << "无法创建输出文件: " << output_filename << std::endl;
            return false;
        }

        // 写入原始数据大小（用于解压时分配缓冲区）
        out_file.write(reinterpret_cast<const char*>(&data_size), sizeof(data_size));
        
        // 写入压缩数据
        out_file.write(reinterpret_cast<const char*>(compressed_buffer.data()), compressed_size);

        if (!out_file.good()) {
            std::cerr << "写入文件失败" << std::endl;
            return false;
        }

        std::cout << "压缩完成: " << data_size << " 字节 -> " << compressed_size 
                  << " 字节 (压缩率: " << (100.0 * compressed_size / data_size) << "%)" << std::endl;
        
        return true;
    }

    // 从压缩文件加载并解压数据到新分配的mmap内存
    static void loadAndDecompress(const std::string& input_filename, void* mapped_data) {
        std::ifstream in_file(input_filename, std::ios::binary);
        if (!in_file) {
            std::cerr << "无法打开输入文件: " << input_filename << std::endl;
            return;
        }

        // 读取原始数据大小
        size_t original_size;
        in_file.read(reinterpret_cast<char*>(&original_size), sizeof(original_size));
        
        if (!in_file.good()) {
            std::cerr << "读取文件头失败" << std::endl;
            return;
        }

        // 计算压缩数据大小
        in_file.seekg(0, std::ios::end);
        size_t compressed_size = in_file.tellg() - sizeof(original_size);
        in_file.seekg(sizeof(original_size), std::ios::beg);

        // 读取压缩数据
        std::vector<Bytef> compressed_data(compressed_size);
        in_file.read(reinterpret_cast<char*>(compressed_data.data()), compressed_size);

        if (!in_file.good()) {
            std::cerr << "读取压缩数据失败" << std::endl;
            return;
        }

        // 解压数据到mmap内存
        uLongf decompressed_size = original_size;
        int result = uncompress(reinterpret_cast<Bytef*>(mapped_data), &decompressed_size,
                               compressed_data.data(), compressed_size);

        if (result != Z_OK || decompressed_size != original_size) {
            std::cerr << "解压失败，错误代码: " << result << std::endl;
            return;
        }

        std::cout << "解压完成: " << compressed_size << " 字节 -> " << decompressed_size << " 字节" << std::endl;
        
        return;
    }
};
#endif