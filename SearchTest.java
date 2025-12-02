package Tests;

import Basetest.Basetestclass;
import org.testng.Assert;
import org.testng.annotations.Test;

public class SearchTest extends Basetestclass {
    @Test
    public void verify() {
        searchpage.enterSearchWord("MacBook");
        searchpage.clicksearch();
        String actualtitle = searchpage.getSearchTitle();
        Assert.assertTrue(actualtitle.contains("Macbook"));

    }
}
