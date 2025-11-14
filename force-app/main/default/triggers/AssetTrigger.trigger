trigger AssetTrigger on Asset (before insert) {
    // Call handler for all before-insert operations
    AssetTriggerHandler.run();
}
