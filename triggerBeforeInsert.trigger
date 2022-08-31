trigger triggerBeforeInsert on Account (before update) {
	Account b = Trigger.old[0];
    Account a = Trigger.new[0];
    //a.name = a.name + ' Delete';
    system.debug('Old Name: '+b.Name);
    system.debug('New Name: '+a.Name);
}