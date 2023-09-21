<?php

use Drupal\DrupalExtension\Context\RawDrupalContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Behat\Tester\Exception\PendingException;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawDrupalContext {

  /**
   * Initializes context.
   *
   * Every scenario gets its own context instance.
   * You can also pass arbitrary arguments to the
   * context constructor through behat.yml.
   */
  public function __construct() {
  }

  /**
   * CVC entry workaround for Windcave.
   *
   * For some reason the Windcave CVC input field doesn't behave as expected;
   * this JS fillField() equivalent works around the issue.
   *
   * @see \Drupal\FunctionalJavascriptTests\JSWebAssert::assertWaitOnAjaxRequest()
   *
   * @Given I fill in Windcave "Cvc2" with ":value"
   */
  public function fillCvc2Input($value) {
    $js = <<<JS
        document.getElementsByName('Cvc2')[0].value = "{$value}";
JS;
    $this->getSession()->executeScript($js);
  }

  /**
   * @Given /^I wait (\d+) seconds?$/
   */
  public function iWaitSeconds($seconds) {
    sleep($seconds);
  }

  /**
   * Stop execution until you hit enter in the console.
   *
   * @see https://stackoverflow.com/questions/45423591/how-to-stop-behat-tests-in-the-middle-to-run-element-inspector
   *
   * @Then /^pause/
   * @Then /^I pause/
   */
  public function pause() {
    fwrite(STDOUT, "\033[s    \033[93m[Breakpoint] Press \033[1;93m[RETURN]\033[0;93m to continue...\033[0m");
    while (fgets(STDIN, 1024) == '') {}
    fwrite(STDOUT, "\033[u");
    return;
  }

}
