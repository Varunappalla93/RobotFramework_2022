from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class shop():

    def __init__(self):
        self.sellib=BuiltIn().get_library_instance("SeleniumLibrary")

    #the given method name will converted to keyword to use.
    @keyword
    def hello_world(self):
        print('Hello World - Python')


    @keyword
    def select_multiple_desired_cards(self,productslist):
        i=1
        productstitles=self.sellib.get_webelements("css:.card-title")
        for producttitles in productstitles:
            if producttitles.text in productslist:
                self.sellib.click_button("xpath:(//div[@class='card-footer'])["+str(i)+"]/button")
            i=i+1

    @keyword
    def click_on_checkout_button(self):
        self.sellib.click_link("xpath://a[@class='nav-link btn btn-primary']")