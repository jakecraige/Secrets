import Quick
import Nimble

class ItWorksSpec: QuickSpec {
    override func spec() {
        describe("The spec") {
            it("works") {
                expect("it works").to(contain("works"))
            }
        }
    }
}


