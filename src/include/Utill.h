#ifndef _UTILL_H_
#define _UTILL_H_

/*****************************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.31, Hangzhou
 * @Update -- 2018.8.1, Hangzhou
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

public: 
    static string ParseDate(int days);
    static string ParseDateTime(int seconds);
    static int CountDays(string date_str);
    static int CountSeconds(string date_time_str);
    static bool IsVariableCandidate(string key);
};

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

#endif