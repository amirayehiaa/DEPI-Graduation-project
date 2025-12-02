package Pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class Searchpage {
    WebDriver driver;
    By searchTitle = By.cssSelector("div[class='container'] Search");
    //from homepage
    By searchbox = By.cssSelector("div[class='col-md-5'] input");
    By searchbutton = By.xpath("//button[@type='button']");

    public Searchpage(WebDriver driver) {
        this.driver = driver;
    }

    public String getSearchTitle() {
        return driver.findElement(searchTitle).getText();
    }
    //from homepage
    public Searchpage clicksearch(){
        driver.findElement(searchbutton).click();
        return new Searchpage(driver);
    }
    public void enterSearchWord(String word){
        driver.findElement(searchbox).sendKeys(word);
    }
    }

