package Pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class Contactuspage {
    WebDriver driver;
    By phonecliker = By.cssSelector("div[class='nav float-end'] [class='fa-solid fa-phone']");
    By name = By.cssSelector("div[class='col-sm-10'] input[id='input-name']");
    By email = By.cssSelector("div[class='col-sm-10'] input[id='input-email']");
    By enquiry = By.cssSelector("div[class='col-sm-10'] input[id='input-enquiry']");
    By submitbutton = By.cssSelector("div[class='text-end'] button");
    public Contactuspage(WebDriver driver){
        this.driver=driver;
    }
    public void entername(String word){
        driver.findElement(name).sendKeys(word);
    }
    public void enteremail(String word){
        driver.findElement(email).sendKeys(word);
    }
    public void enterenquiry(String word){
        driver.findElement(enquiry).sendKeys(word);
    }
    public void clicksubmit(){
        driver.findElement(submitbutton).click();
}
    public void clickphone(){
        driver.findElement(phonecliker).click();
    }
}
