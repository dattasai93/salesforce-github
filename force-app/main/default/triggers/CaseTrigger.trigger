trigger CaseTrigger on Case (before insert) {
    for (Case c : Trigger.new) {
        if (c.Origin == null) {
            c.Origin = 'Web';
        }

        if (c.Priority == null) {
            c.Priority = 'Medium';
        }

        System.debug('New Case created with Subject: ' + c.Subject);
    }
}