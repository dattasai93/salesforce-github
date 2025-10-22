trigger AssetTrigger on Assert (before insert) {
    AssetTriggerHandler.run();
    AccountHandler.run();
    for (Asset asset : Trigger.New) {
        System(' Asset: Account ID '+asset.AccountId);
        
    }

}
