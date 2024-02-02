#ifndef _ANY_VECTORR_
#define _ANY_VECTORR_

#include "Entity.h"

class AnyVectorr 
{
private:
    vector <Entity *> elements_value;
    vector <int> elements_R_type;

    int row;
    int clm;

public:
    AnyVectorr(DataInputStream &in);
    ~AnyVectorr();

    Entity* getEntity(int index) {return elements_value[index];}
    vector <int>& getRType() {return elements_R_type;}
};

AnyVectorr::AnyVectorr(DataInputStream &in)
{
    in.readInt(row);
    in.readInt(clm);
    int size = row * clm;
    elements_value.reserve(size);
    elements_R_type.reserve(size);

    for (int i = 0; i < size; i++)
    {
        short flag{};
        in.readShort(flag);

        int form = flag >> 8;
        int type = flag & 0xff;
        Entity* entity = new Entity(form, type, in);

        elements_value.push_back(entity);
        elements_R_type.push_back(Utill::ReturnRType(form, type));
    }
}

AnyVectorr::~AnyVectorr()
{
    for (unsigned int i = 0; i < elements_value.size(); i++)
    {
        if (elements_value[i] != NULL)
        {
            delete elements_value[i];
            elements_value[i] = NULL;
        }
    }
}


#endif