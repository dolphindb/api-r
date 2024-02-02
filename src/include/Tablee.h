#ifndef _TABLEE_H_
#define _TABLEE_H_

/****************************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.23, Hangzhou
 * 
 ****************************************************/

#include <string>
#include <vector>

#include "Vectorr.h"
#include "Socket/SysIO.h"

/******************************************************************
 *
 * @Description
 * 
 *  Class of TABLE (DataFrame)
 *  
 *  Store basic information of a table
 *  Store every columns in the form of Vector
 *
 ******************************************************************/
class Tablee
{
private: 
    int table_row;
    int table_clm;
    string table_name;

    vector <int> column_type;
    vector <string> column_name;
    vector <Vectorr *> all_columns;

public:
    Tablee(DataInputStream &in);
    ~Tablee();

    int getTableRow() {return table_row;}
    int getTableClm() {return table_clm;}
    string getTableName() {return table_name;}
    vector <int>& getTableClmType() {return column_type;}
    vector <string>& getTableClmName() {return column_name;}
    Vectorr*& getTableClm(int i) {return all_columns[i];}
    void TableClear();
};

Tablee::Tablee(DataInputStream &in)
{
    in.readInt(table_row);
    in.readInt(table_clm);
    in.readString(table_name);

    column_type.reserve(table_clm);
    column_name.reserve(table_clm);
    all_columns.resize(table_clm, NULL);

    for (int i = 0; i < table_clm; i++)
    {
        string temp;
        in.readString(temp);
        column_name.push_back(temp);
    }

    for (int i = 0; i < table_clm; i++)
    {
        short flag{};
        in.readShort(flag);
        int form = flag >> 8;
        int type = flag & 0xff;

        // cout << "form:" << form << " " << "type:" << type << endl;

        if (form != DATA_FORM::DF_VECTOR)
        {
            cout << "[ERROR] Invalid form of column " << i << endl;
        }

        int R_type = CreateVector(all_columns[i], type, in);

        column_type.push_back(R_type);
    }
}

Tablee::~Tablee()
{
    for (unsigned int i = 0; i < all_columns.size(); i++)
    {
        delete all_columns[i];
        all_columns[i] = NULL;
    }
}

#endif