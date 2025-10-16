trigger AssetTrigger on Assert (before insert) {
    for (Asset asset : Trigger.New) {
        System(' Asset: Account ID '+asset.AccountId);
        
    }

}