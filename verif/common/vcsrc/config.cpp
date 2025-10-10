#include "config.h"
#include <sys/stat.h>
#include <unistd.h>
#include <cstdlib>
#if __cplusplus >= 201703L
#include <filesystem>
#endif

Config::Config()
{
    set_timestamp();
}

Config::Config(const char *f) : Config()
{
    file = f;
}

Config::Config(int in_argc, char **argv) : Config()
{
    if (in_argc < 2)
    {
        std::abort();
    } else {
        file = argv[1];
    }
}

void Config::open_file()
{
    fd.open(file, std::ios::in);
}

void Config::read_config()
{
    open_file();
    if (!fd.is_open())
    {
        std::cerr << "Open config file [" << file << "] error!" << std::endl;
        std::abort();
        return;
    }
    else
    {
        std::cout << "Config file [" << file << "] is opened" << std::endl;
    }
    std::string tp;
    while (getline(fd, tp))
    {

        auto pos = tp.find("=");
        std::string key, value;
        if (pos != tp.npos)
        {
            const char *w = " \t\n\r\f\v";
            key = trim(tp.substr(0, pos), w);
            value = trim(tp.substr(pos + 1), w);
            /* lines begin with # are comments */
            if (key[0] != '#') {
                this->option[key] = value;
            }
        }
    }
}

Config::~Config()
{
    if (fd.is_open())
    {
        fd.close();
    }
}

void Config::set_timestamp()
{
    time_t timep;
    time(&timep);
    char tmp[256];
    strftime(tmp, sizeof(tmp), "%Y%m%d%H%M%S", localtime(&timep));
    timestamp = tmp;
}

/**
 * @brief clean dest and link src to dest
 * 
 * @param src real file
 * @param dest symbol file
 * @return true if create success
 * @return false if create failure
 */
bool Config::link_to(std::string src, std::string dest)
{
    std::string src_relative = relative_path(src, dest);
    const char * dest_c = static_cast<const char *>(dest.c_str());
    const char * src_c  = static_cast<const char *>(src_relative.c_str());

    unlink(dest_c);

    int sym_ret = symlink(src_c, dest_c);
    if (sym_ret != 0)
    {
        perror("symlink_error");
        return false;
    }
    return true;
}

/**
 * @brief get relative path from dest to src
 * 
 * @param src source path
 * @param dest dest path/base path
 * @return std::string 
 */
std::string Config::relative_path(std::string src, std::string dest)
{
    std::string relative_path = "";
#if __cplusplus >= 201703L
    std::filesystem::path src_path(src);
    std::filesystem::path dest_path(dest);
    if (dest_path.has_filename()) {
        relative_path = std::filesystem::relative(src_path, dest_path.parent_path());
    } else {
        relative_path = std::filesystem::relative(src_path, dest_path);
    }
#else
    char* actualpath = realpath(src.c_str(), NULL);
    if(actualpath == nullptr) {
        perror("realpath");
        exit(EXIT_FAILURE);
    }
    std::string ret = std::string(actualpath);
    free(actualpath);
    return ret;
#endif
    return relative_path;
}


std::vector<std::string> Config::split(const std::string& str, const std::string& pattern) {
    std::vector<std::string> result;
    std::string::size_type begin, end;

    end = str.find(pattern);
    begin = 0;

    while (end != std::string::npos) {
        if (end - begin != 0) {
            result.push_back(str.substr(begin, end-begin)); 
        }    
        begin = end + pattern.size();
        end = str.find(pattern, begin);
    }

    if (begin != str.length()) {
        result.push_back(str.substr(begin));
    }
    return result;        
}

bool Config::has_key(std::string key) {
    return this->option.count(key);
}
std::string Config::get_value(std::string key) {
    if (!this->option.count(key)) {
        fprintf(stderr, "key \"%s\" not found\n", key.c_str());
        abort();
    }
    return this->option[key];
}

bool Config::get_value_or_bool(const std::string& key, bool v_default){
    if (this->option.count(key)) {
        long long ret = std::stoll(this->option[key],nullptr,0);
        if(ret < 0 || ret > 1){
            fprintf(stderr, "value of key \"%s\" is not a boolean\n", key.c_str());
            abort();
        }
        return ret;
    }
    return v_default;
}

long long Config::get_value_or_else(const std::string& key, long long v_default){
    if (this->option.count(key)) {
        return std::stoll(this->option[key],nullptr,0);
    }
    return v_default;
}

const char* Config::get_value_or_cstr(const std::string& key, const char* v_default){
    if (this->option.count(key)) {
        return this->option[key].c_str();
    }
    return v_default;
}
