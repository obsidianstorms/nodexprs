import {
    RollValidation
} from "../src";
import { expect } from "chai";
import "mocha";

describe("Roll Validation", function () {
   this.timeout(5000);
   describe("with invalid options", async () => {
       describe("check dice max size", async () => {
           it("returns error message if size value is not included", async () => {
               const dice = {
               };
               const validator = new RollValidation();
               try {
                   validator.check(dice);
                   // Expect a test failure if check doesn't throw Error
                   expect(true, "Function executed successfully when it shouldn't have.").to.be.false;
               } catch (err) {
                   expect(err.name, err.message).to.equal("Error");
                   expect(err.message).to.have.string("Dice object does not contain a size value.");
               }
           });
           it("returns error message if dice value is not included", async () => {
               const dice = {
                   "size": 1
               };
               const validator = new RollValidation();
               try {
                   validator.check(dice);
                   // Expect a test failure if check doesn't throw Error
                   expect(true, "Function executed successfully when it shouldn't have.").to.be.false;
               } catch (err) {
                   expect(err.name, err.message).to.equal("Error");
                   expect(err.message).to.have.string("Dice object does not contain a dice value.");
               }
           });
           it("returns error message if drop value is not included", async () => {
               const dice = {
                   "size": 1,
                   "dice": 1
               };
               const validator = new RollValidation();
               try {
                   validator.check(dice);
                   // Expect a test failure if check doesn't throw Error
                   expect(true, "Function executed successfully when it shouldn't have.").to.be.false;
               } catch (err) {
                   expect(err.name, err.message).to.equal("Error");
                   expect(err.message).to.have.string("Dice object does not contain a drop value.");
               }
           });
           it("returns error message if size is a true bool", async () => {
               const dice = {
                   "size": true,
                   "dice": 1,
                   "drop": 0
               };
               const validator = new RollValidation();
               try {
                   validator.check(dice);
                   // Expect a test failure if check doesn't throw Error
                   expect(true, "Function executed successfully when it shouldn't have.").to.be.false;
               } catch (err) {
                   expect(err.name, err.message).to.equal("Error");
                   expect(err.message).to.equal("Dice max value is not a number.");
               }
           });
           it("returns error message if size is a false bool", async () => {
               const dice = {
                   "size": false,
                   "dice": 1,
                   "drop": 0
               };
               const validator = new RollValidation();
               try {
                   validator.check(dice);
                   // Expect a test failure if check doesn't throw Error
                   expect(true, "Function executed successfully when it shouldn't have.").to.be.false;
               } catch (err) {
                   expect(err.name, err.message).to.equal("Error");
                   expect(err.message).to.equal("Dice max value is not a number.");
               }
           });
           it("returns error message if size is a string", async () => {
               const dice = {
                   "size": "xyz",
                   "dice": 1,
                   "drop": 0
               };
               const validator = new RollValidation();
               try {
                   validator.check(dice);
                   // Expect a test failure if check doesn't throw Error
                   expect(true, "Function executed successfully when it shouldn't have.").to.be.false;
               } catch (err) {
                   expect(err.name, err.message).to.equal("Error");
                   expect(err.message).to.equal("Dice max value is not a number.");
               }
           });
           it("returns error message if size is an object", async () => {
               const dice = {
                   "size": {"xyz": "xyz"},
                   "dice": 1,
                   "drop": 0
               };
               const validator = new RollValidation();
               try {
                   validator.check(dice);
                   // Expect a test failure if check doesn't throw Error
                   expect(true, "Function executed successfully when it shouldn't have.").to.be.false;
               } catch (err) {
                   expect(err.name, err.message).to.equal("Error");
                   expect(err.message).to.equal("Dice max value is not a number.");
               }
           });
           it("returns error message if size is less than 0", async () => {
               const dice = {
                   "size": -1,
                   "dice": 1,
                   "drop": 0
               };
               const validator = new RollValidation();
               try {
                   validator.check(dice);
                   // Expect a test failure if check doesn't throw Error
                   expect(true, "Function executed successfully when it shouldn't have.").to.be.false;
               } catch (err) {
                   expect(err.name, err.message).to.equal("Error");
                   expect(err.message).to.equal("Dice max value should not be less than 0.");
               }
           });
           it("returns error message if size is greater than 100", async () => {
               const dice = {
                   "size": 101,
                   "dice": 1,
                   "drop": 0
               };
               const validator = new RollValidation();
               try {
                   validator.check(dice);
                   // Expect a test failure if check doesn't throw Error
                   expect(true, "Function executed successfully when it shouldn't have.").to.be.false;
               } catch (err) {
                   expect(err.name, err.message).to.equal("Error");
                   expect(err.message).to.equal("Dice max value should not be greater than 100.");
               }
           });
       });
   });
});