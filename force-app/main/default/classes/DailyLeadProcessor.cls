global class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext cxt){
        List<Lead> lds=[select Id,Name,LeadSource from Lead where LeadSource=''];
        modifyLeadSource(lds);
    }
    public void modifyLeadSource(List<Lead> acpt){
        for(Lead ld:acpt){
            ld.LeadSource='Dreamforce';
        }
        update acpt;
    }
}