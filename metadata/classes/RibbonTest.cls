@isTest
private class RibbonTest {
	
	@isTest static void getTipoTest() {
		List<String> res = Ribbon.getTipos('Opportunity', 'StageName', 'Amount', 'CloseDate', 'FiscalYear', 'StageName', 'StageName', 'StageName');

	
			System.assertEquals(7,res.size());
		
	}
	
	@isTest static void getQTest() {
		Account a = new Account (Name ='XXX');
        insert a;
		List<Object> res = Ribbon.getValores(a.id,'Account', 'IsPartner', 'LastActivityDate', 'Type', 'Phone', 'Fax', 'Rating', 'Site');

	
			System.assertEquals(7,res.size());
		
	}
	
}