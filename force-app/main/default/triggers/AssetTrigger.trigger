trigger AssetTrigger on Asset (before insert) {
    AssetTriggerHandler.run();
}
