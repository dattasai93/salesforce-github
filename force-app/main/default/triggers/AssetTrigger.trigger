trigger AssetTrigger on Asset (before insert) {
    
    AssetTriggerHandler.run();
    AccountHandler.run();

    
    for (Asset asset : Trigger.new) {
        System.debug('Asset: Account ID = ' + asset.AccountId);
    }
}