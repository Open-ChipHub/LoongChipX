#ifndef _CONFIG_H_
#define _CONFIG_H_
#include <vector>
#include <map>
#include <string>
#include <iostream>
#include <fstream>

class Config
{
public:
    int argc = 1;
    std::string timestamp;

private:
    /* config file path */
    std::string file;
    std::fstream fd;

    /* key value storage */
    std::map<std::string, std::string> option;

    void open_file();

    // trim from both ends of string (right then left)
    inline std::string trim(std::string s, const char *t)
    {
        s.erase(s.find_last_not_of(t) + 1);
        s.erase(0, s.find_first_not_of(t));
        return s;
    }

    void set_timestamp();
    std::string relative_path(std::string, std::string);
    std::vector<std::string> split(const std::string&, const std::string&);

public:
    Config();
    Config(const char *);
    Config(int, char **);
    ~Config();

    void read_config();
    bool link_to(std::string, std::string);
    bool has_key(std::string);
    std::string get_value(std::string);
    bool get_value_or_bool(const std::string&, bool);
    long long get_value_or_else(const std::string&, long long);
    const char* get_value_or_cstr(const std::string&, const char*);
};
#endif
