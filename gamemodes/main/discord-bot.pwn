stock SendLogToDiscordRoom(const TitleEmbed[], const channel[], const FieldName[], const FieldValue[], const FieldName2[], const FieldValue2[], const FieldName3[], const FieldValue3[], const FieldColor)
{
    new wepdate[100], dayz, monthz, yearz, hourz, minutez, secondz;
    new DCC_Embed:embed = DCC_CreateEmbed(TitleEmbed);
    DCC_SetEmbedColor(embed, FieldColor);
    DCC_AddEmbedField(embed, FieldName, FieldValue, true);
    DCC_AddEmbedField(embed, FieldName2, FieldValue2, true);
    DCC_AddEmbedField(embed, FieldName3, FieldValue3, true);
    getdate(yearz, monthz, dayz);
    gettime(hourz, minutez, secondz);
    format(wepdate, sizeof(wepdate), "%d:%d:%d - %d/%d/%d", hourz, minutez, secondz, dayz, monthz, yearz);
    DCC_SetEmbedFooter(embed, wepdate);
    DCC_SendChannelEmbedMessage(DCC_FindChannelById(channel), embed);
    return 1;
}

stock SendLogToDiscordRoom4(const TitleEmbed[], const channel[], const FieldName[], const FieldValue[], const FieldName2[], const FieldValue2[], const FieldName3[], const FieldValue3[], const FieldName4[], const FieldValue4[], const FieldColor)
{
    new wepdate[100], dayz, monthz, yearz, hourz, minutez, secondz;
    new DCC_Embed:embed = DCC_CreateEmbed(TitleEmbed);
    DCC_SetEmbedColor(embed, FieldColor);
    DCC_AddEmbedField(embed, FieldName, FieldValue, true);
    DCC_AddEmbedField(embed, FieldName2, FieldValue2, true);
    DCC_AddEmbedField(embed, FieldName3, FieldValue3, true);
    DCC_AddEmbedField(embed, FieldName4, FieldValue4, true);
    getdate(yearz, monthz, dayz);
    gettime(hourz, minutez, secondz);
    format(wepdate, sizeof(wepdate), "%d:%d:%d - %d/%d/%d", hourz, minutez, secondz, dayz, monthz, yearz);
    DCC_SetEmbedFooter(embed, wepdate);
    DCC_SendChannelEmbedMessage(DCC_FindChannelById(channel), embed);
    return 1;
}
