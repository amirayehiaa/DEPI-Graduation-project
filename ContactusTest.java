package Tests;

import BaseTest.BaseTestClass;
import org.testng.annotations.Test;

public class ContactusTest extends BaseTestClass {
    @Test
    public void verify(){

        contactuspage.clickphone();
        contactuspage.entername("Mazen elsaied abd elgaffar");
        contactuspage.enteremail("mazenelsaied85@gmail.com");
        contactuspage.enterenquiry("what is the rules of this website");
        contactuspage.clicksubmit();
    }
}
