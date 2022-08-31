trigger FourthAssQ3 on Account (after delete)
{
	List<Account> acList = Trigger.old;
    List<Account_backup__c> backupList = new List<Account_backup__c>();
    List<Account> accList = [ Select Name from Account where IsDeleted = True AND id in : Trigger.old ALL ROWS];
    
    for(Account acc : accList)
    {
        if(String.isNotBlank(acc.MasterRecordId))
        {
            backupList.add(new Account_backup__c(Name=acc.Name, Phone_Number__c=acc.Phone));
        }
    }
	system.debug(backupList);
    insert backupList;
}