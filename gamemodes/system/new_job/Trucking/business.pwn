#define MAX_ORDERTRUCKER    (10) // Tối đa 10 lần order

enum BusinessTrucker{
    Id,
    BusinessId,
    ProductId,
    Quantity,
    Price, //Giá cho 1 lượt giao
    Exsits
};

new BusinessTrucker[MAX_BUSINESSES][MAX_ORDERTRUCKER][BusinessTrucker];

stock LoadBusinessTrucker()
{
	for(new businessid; businessid < MAX_BUSINESSES; businessid++)
	{
		for(new i; i < MAX_ORDERTRUCKER; i++)
		{
			BusinessTrucker[businessid][i][Exsits] = false;
			BusinessTrucker[businessid][i][Quantity] = 0;
		}
	}
	printf("[Load Order Trucker Biz] Loading data from database...");
	mysql_function_query(MainPipeline, "SELECT * FROM businesstrucker", true, "OnLoadBusinessTrucker", "");
    return 1;
}

public OnLoadBusinessTrucker()
{
    
	new i, rows, fields, tmp[128], businessid, index, oldbusinessid = -1;
	cache_get_data(rows, fields, MainPipeline);
	while(i < rows)
	{
		cache_get_field_content(i, "OwnerBusiness", tmp, MainPipeline); businessid = strval(tmp);
		if(businessid != oldbusinessid)
		{
			index = 0;
			oldbusinessid = businessid;
		}
		cache_get_field_content(i, "Id", tmp, MainPipeline); BusinessTrucker[--businessid][index][Id] += strval(tmp);
		cache_get_field_content(i, "Quantity", tmp, MainPipeline); BusinessTrucker[businessid][index][Quantity] = strval(tmp);
		cache_get_field_content(i, "ProductName", tmp, MainPipeline); BusinessTrucker[businessid][index][ProductId] = strval(tmp);
        BusinessTrucker[businessid][index][Exsits] = true;
  		i++;
		index++;
 	}
	if(i > 0) printf("[Load Order Trucker Biz] %d du lieu dat hang cua hang %s da duoc tai.", i, Businesses[businessid][bName]);
    return 1;
}
