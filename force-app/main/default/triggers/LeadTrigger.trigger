trigger LeadTrigger on Lead (before insert) {
    for (Lead l : Trigger.new) {
        if (String.isBlank(l.Status)) {
            l.Status = 'New';
        }
        if (String.isBlank(l.LeadSource)) {
            l.LeadSource = 'Web';
        }
    }
}
