task FactoryTimer[60000]()
{
    for(new i; i < sizeof(FactoryData); i++)
    {
        for(new j; j < strlen(FactoryData[i][ProductName]); j++)
        {
            if(FactoryData[i][WareHouse][j] < FactoryData[i][MaxWareHouse][j])
                FactoryData[i][WareHouse][j] = (FactoryData[i][WareHouse][j] + FactoryData[i][Productivity][j]) > FactoryData[i][MaxWareHouse][j] ? FactoryData[i][MaxWareHouse][j] : (FactoryData[i][WareHouse][j] + FactoryData[i][Productivity][j]);
            if(FactoryData[i][ImportWareHouse][j] < FactoryData[i][ImportMaxWareHouse][j])
                FactoryData[i][ImportWareHouse][j] = (FactoryData[i][ImportWareHouse][j] - FactoryData[i][ProductImport][j]) <= 0 ? 0 : (FactoryData[i][ImportWareHouse][j] - FactoryData[i][ProductImport][j]);
        }
    }
}