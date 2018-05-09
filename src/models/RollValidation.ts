// Validation expressly done to provide user feedback
// Typescript classes could handle this via interfaces
class RollValidation {
    private _max;
    private _min;

    public constructor() {
        this._max = 100;
        this._max = 0;
    }

    public check(dice) {
        this._shouldHave(dice, "size");
        this._shouldHave(dice, "dice");
        this._shouldHave(dice, "drop");

        this._shouldBeNumber(dice.size,"Dice max value is not a number.");
        this._shouldBeGreaterThan(dice.size,this._min,`Dice max value should not be less than ${this._min}.`);
        this._shouldBeLessThan(dice.size,this._max,`Dice max value should not be greater than ${this._max}.`);

    }

    protected _shouldHave(dice, expectation) {
        if (!(expectation in dice)) {
            throw new Error(`Dice object does not contain a ${expectation} value.`)
        }
    }

    protected _shouldBeNumber(value, message) {
        if (typeof value !== "number") {
            throw new Error(message);
        }
    }

    protected _shouldBeGreaterThan(value, min, message) {
        if (value < min) {
            throw new Error(message)
        }
    }

    protected _shouldBeLessThan(value, max, message) {
        if (typeof value > max) {
            throw new Error(message);
        }
    }
}

export default RollValidation;
