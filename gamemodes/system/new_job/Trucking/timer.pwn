task FactoryTimer[60000]()
{
    for(new i; i < sizeof(FactoryData); i++)
    {
        for(new j; j < strlen(FactoryData[i][ProductName]); j++)
        {
            if(FactoryData[i][Productivity][j] < FactoryData[i][MaxWareHouse][j])
                FactoryData[i][Productivity][j] = (FactoryData[i][Productivity][j] + FactoryData[i][Productivity][j]) > FactoryData[i][MaxWareHouse][j] ? FactoryData[i][MaxWareHouse][j] : (FactoryData[i][Productivity][j] + FactoryData[i][Productivity][j]);
        }
    }
}