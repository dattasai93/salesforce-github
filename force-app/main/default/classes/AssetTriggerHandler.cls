private static void handleBeforeInsert(List<Asset> newAssets) {
    // Filter Assets that need a default Account
    List<Asset> assetsNeedingAccount = new List<Asset>();
    for (Asset a : newAssets) {
        if (a.AccountId == null && a.ContactId == null) {
            assetsNeedingAccount.add(a);
        }
        if (a.Status == null) {
            a.Status = 'Active';
        }
    }

    if (!assetsNeedingAccount.isEmpty()) {
        Account defaultAcc = [SELECT Id FROM Account LIMIT 1];
        for (Asset a : assetsNeedingAccount) {
            a.AccountId = defaultAcc.Id;
        }
    }
}
