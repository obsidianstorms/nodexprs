declare class RollValidation {
    private _max;
    private _min;
    constructor();
    check(dice: any): void;
    protected _shouldHave(dice: any, expectation: any): void;
    protected _shouldBeNumber(value: any, message: any): void;
    protected _shouldBeGreaterThan(value: any, min: any, message: any): void;
    protected _shouldBeLessThan(value: any, max: any, message: any): void;
}
export default RollValidation;
