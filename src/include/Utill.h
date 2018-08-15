#ifndef _UTILL_H_
#define _UTILL_H_

/*****************************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.31, Hangzhou
 * @Update -- 2018.8.15, Hangzhou
 * 
 *****************************************************/

/*****************************************************
 *
 * @Description
 *  
 *  Implement some functions can be called directly.
 * 
 *****************************************************/

#include <iostream>
#include <string>
#include <sstream>
using std::string;
using std::cout;
using std::endl;
using std::stringstream;

#include "Socket/SysIO.h"
#include "Socket/Types.h"
#include "R_Type.h"

class Utill 
{
private: 
    static string FormatRDate(int year = 1970, int month = 1, int day = 1);
    static string FormatRDateTime(int year = 1970, int month = 1, int day = 1, int hour = 0, int minute = 0, int second = 0);
    static string FormatRDateTime(string date_str, int hour = 0, int minute = 0, int second = 0);
public: 
    static string ErrorTypeNotSupport;
    static string ErrorFormNotSupport;
    static string WarnPrecisonLost;

    static string ParseDate(int days);
    static string ParseDateTime(int seconds);
    static string ParseMonth(int months);
    static string ParseMinute(int minutes);
    static string ParseSecond(int seconds);
    static string ParseTime(int milliseconds);
    static string ParseTimestamp(long long milliseconds);
    static string ParseNanotime(long long nanoseconds);
    static string ParseNanotimestamp(long long nanoseconds);
    static int CountDays(string date_str);
    static int CountSeconds(string date_time_str);
    static bool IsVariableCandidate(string key);
};

string Utill::ErrorTypeNotSupport = "[ERROR] Data type not support in R";
string Utill::ErrorFormNotSupport = "[ERROR] Data form not support in R";
string Utill::WarnPrecisonLost = "[WARNING] Precison may lost in casting";

string Utill::ParseNanotimestamp(long long nanoseconds)
{
    long long NANOS_PER_DAY = 24L*60L*60L*1000000000L;
    int days = (int) floor((double)nanoseconds / NANOS_PER_DAY);
    string date_str = ParseDate(days);

    nanoseconds %= NANOS_PER_DAY;
    if (nanoseconds < 0)
    {
        nanoseconds += NANOS_PER_DAY;
    }
    
    nanoseconds %= NANOS_PER_DAY;
    int hours = (int)(nanoseconds / (60L*60L*1000000000L));
    nanoseconds -= hours * (60L*60L*1000000000L);
    int minutes = (int)(nanoseconds / (60L*1000000000L));
    nanoseconds -= minutes * (60L*1000000000L);
    int seconds = (int)(nanoseconds / (1000000000L));
    nanoseconds -= seconds * (1000000000L);

    return FormatRDateTime(date_str, hours, minutes, seconds);
}

string Utill::ParseNanotime(long long nanoseconds)
{
    int hours = (int)(nanoseconds / (60L*60L*1000000000L));
    nanoseconds -= hours * (60L*60L*1000000000L);
    int minutes = (int)(nanoseconds / (60L*1000000000L));
    nanoseconds -= minutes * (60L*1000000000L);
    int seconds = (int)(nanoseconds / (1000000000L));
    nanoseconds -= seconds * (1000000000L);

    return FormatRDateTime(1970, 1, 1, hours, minutes, seconds);
}

string Utill::ParseTimestamp(long long milliseconds)
{
    int days = (int) floor((double) milliseconds / 86400000.0);
    string date_str = ParseDate(days);

    milliseconds %= 86400000L;
    if(milliseconds < 0)
    {
        milliseconds += 86400000;
    }
    int millisecond = (int)(milliseconds % 1000);
    int seconds = (int)(milliseconds / 1000);
    int hour = seconds / 3600;
    seconds %= 3600;
    int minute = seconds / 60;
    int second = seconds % 60;

    return FormatRDateTime(date_str, hour, minute, second);
}

string Utill::ParseSecond(int seconds)
{
    int hour = seconds / 3600;
    int minute = seconds % 3600 / 60;
    int second = seconds % 60;

    return FormatRDateTime(1970, 1, 1, hour, minute, second);
}

string Utill::ParseMinute(int minutes)
{
    int hour = minutes / 60;
    int minute = minutes % 60;

    return FormatRDateTime(1970, 1, 1, hour, minute);
}

string Utill::ParseTime(int milliseconds)
{
    int hour = milliseconds / 3600000;
    int minute = milliseconds / 60000 % 60;
    int second = milliseconds / 1000 % 60;
    // int milli = milliseconds % 1000 * 1000000;

    return FormatRDateTime(1970, 1, 1, hour, minute, second);
}

string Utill::ParseMonth(int months)
{
    int year = months / 12;
    int month = months % 12 + 1;

    return FormatRDate(year, month);
}

string Utill::ParseDate(int days)
{
    int year;
    int month;
    int day;

    days += 719529;
    int circleIn400Years = days / 146097;
    int offsetIn400Years = days % 146097;
    int resultYear = circleIn400Years * 400;
    int similarYears = offsetIn400Years / 365;
    int tmpDays = similarYears * 365;
    if (similarYears > 0)
    {
        tmpDays += (similarYears - 1) / 4 + 1 - (similarYears - 1) / 100;
    }
    if (tmpDays >= offsetIn400Years)
    {
        --similarYears;
    }
    year = similarYears + resultYear;
    days -= circleIn400Years * 146097 + tmpDays;
    bool leap = ((year%4==0 && year%100!=0) || year%400==0);
    if (days <= 0)
    {
        days += leap ? 366 : 365;
    }
    if (leap)
    {
        month = days / 32 + 1;
        if (days > cumLeapMonthDays[month])
        {
            month++;
        }
        day = days - cumLeapMonthDays[month-1];
    }
    else 
    {
        month = days / 32 + 1;
        if (days > cumMonthDays[month])
        {
            month++;
        }
        day = days - cumMonthDays[month-1];
    }

    return FormatRDate(year, month, day);
}

string Utill::ParseDateTime(int seconds)
{
    string date_str;
    int days = seconds / 86400;
    if (seconds >= 0)
    {
        date_str = Utill::ParseDate(days);
    }
    else
    {
        date_str = Utill::ParseDate(days-1);
    }
    seconds %= 86400;
    int hour = seconds / 3600;
    seconds %= 3600;
    int minute = seconds / 60;
    int second = seconds % 60;

    return FormatRDateTime(date_str, hour, minute, second);
}

int Utill::CountDays(string date_str)
{
    string year_str(date_str, 0, 4);
    string month_str(date_str, 5, 2);
    string day_str(date_str, 8, 2);
    int year;
    int month;
    int day;
    stringstream ss;

    ss << year_str;
    ss >> year;
    ss.str("");
    ss.clear();

    ss << month_str;
    ss >> month;
    ss.str("");
    ss.clear();

    ss << day_str;
    ss >> day;
    ss.str("");
    ss.clear();

    if (month < 1 || month > 12 || day < 0)
    {
        return DDB_NULL_INTEGER;
    }
    
    int divide400Years = year / 400;
    int offset400Years = year % 400;
    int days = divide400Years * 146097 + offset400Years * 365 - 719529;
    if (offset400Years > 0)
    {
        days += (offset400Years-1) / 4 + 1 - (offset400Years-1) / 100;
    }
    if ((year%4==0 && year%100 != 0) || year%400==0)
    {
        days += cumLeapMonthDays[month-1];
        return day <= leapMonthDays[month-1] ? days + day : DDB_NULL_INTEGER;
    }
    else 
    {
        days += cumMonthDays[month-1];
        return day <= monthDays[month-1] ? days + day : DDB_NULL_INTEGER;
    }
}

int Utill::CountSeconds(string date_time_str)
{
    string date_str(date_time_str, 0, 10);
    string time_str(date_time_str, 11, time_str.size() - 11);

    string hour_str(time_str, 0, 2);
    string minute_str(time_str, 3, 2);
    string second_str(time_str, 6, 2);
    int hour;
    int minute;
    int second;
    stringstream ss;

    ss << hour_str;
    ss >> hour;
    ss.str("");
    ss.clear();

    ss << minute_str;
    ss >> minute;
    ss.str("");
    ss.clear();

    ss << second_str;
    ss >> second;
    ss.str("");
    ss.clear();

    int days = Utill::CountDays(date_str);
    return days * 86400 + (hour * 60 + minute) * 60 + second;
}

bool Utill::IsVariableCandidate(string key)
{
    char cur = key[0];
    if ((cur < 'a' || cur > 'z') && (cur < 'A' || cur > 'Z'))
    {
        return false;
    }
    for (int i = 1; i < key.length(); i++)
    {
        cur = key[i];
        if ((cur<'a' || cur>'z') && (cur<'A' || cur>'Z') && (cur<'0' || cur>'9') && cur!='_')
        {
            return false;
        }
    }
    return true;
}

string Utill::FormatRDate(int year, int month, int day)
{
    string date_str;
    string year_str;
    string month_str;
    string day_str;
    stringstream ss;

    ss.fill('0');
    ss.width(4);
    ss << year;
    year_str.assign(ss.str());
    ss.str("");
    ss.clear();

    ss.fill('0');
    ss.width(2);
    ss << month;
    month_str.assign(ss.str());
    ss.str("");
    ss.clear();
    
    ss.fill('0');
    ss.width(2);
    ss << day;
    day_str.assign(ss.str());
    ss.str("");
    ss.clear();

    date_str = year_str + "-" + month_str + "-" + day_str;
    return date_str;
}

string Utill::FormatRDateTime(int year, int month, int day, int hour, int minute, int second)
{
    string date_str = FormatRDate(year, month, day);

    string hour_str;
    string minute_str;
    string second_str;
    stringstream ss;

    ss.fill('0');
    ss.width(2);
    ss << hour;
    hour_str = ss.str();
    ss.str("");
    ss.clear();

    ss.fill('0');
    ss.width(2);
    ss << minute;
    minute_str = ss.str();
    ss.str("");
    ss.clear();

    ss.fill('0');
    ss.width(2);
    ss << second;
    second_str = ss.str();
    ss.str("");
    ss.clear();

    date_str += " ";
    date_str += hour_str;
    date_str += ":";
    date_str += minute_str;
    date_str += ":";
    date_str += second_str;
    return date_str;
}

string Utill::FormatRDateTime(string date_str, int hour, int minute, int second)
{
    string hour_str;
    string minute_str;
    string second_str;
    stringstream ss;

    ss.fill('0');
    ss.width(2);
    ss << hour;
    hour_str = ss.str();
    ss.str("");
    ss.clear();

    ss.fill('0');
    ss.width(2);
    ss << minute;
    minute_str = ss.str();
    ss.str("");
    ss.clear();

    ss.fill('0');
    ss.width(2);
    ss << second;
    second_str = ss.str();
    ss.str("");
    ss.clear();

    date_str += " ";
    date_str += hour_str;
    date_str += ":";
    date_str += minute_str;
    date_str += ":";
    date_str += second_str;
    return date_str;
}

#endif