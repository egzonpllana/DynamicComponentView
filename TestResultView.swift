//
//  Created by Egzon Pllana on 13/07/20.
//

import UIKit

class TestResultView: XibControl {

    // MARK: - Outlets

    @IBOutlet private weak var yourScoreView: UIView!
    @IBOutlet private weak var availableValueView: UIView!
    @IBOutlet private weak var requiredValueView: UIView!
    @IBOutlet private weak var currentValueView: UIView!
    @IBOutlet private weak var requiredScoreView: UIView!
    @IBOutlet private weak var yourScoreLabel: UILabel!
    @IBOutlet private weak var requiredScoreLabel: UILabel!
    @IBOutlet private weak var pointsLabel: UILabel!
    @IBOutlet private weak var actualPointsLabel: UILabel!
    @IBOutlet private weak var totalPointsLabel: UILabel!
    @IBOutlet private weak var passedLabel: UILabel!
    @IBOutlet private weak var notPassedLabel: UILabel!

    // MARK: - Constraints Constants

    @IBOutlet private weak var yourScoreViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var requiredScoreViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var currentValueViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var requiredValueViewWidthConstraint: NSLayoutConstraint!

    // MARK: - Properties

    private var nibName = "TestResultView"

    // MARK: - Required inits

    // NOTE: Must override even if nothing special is done to allow subclasses to call it
    override init(frame: CGRect) {
        super.init(frame: frame, nibName: nibName)
        setupView()
    }

    // NOTE: Must override even if nothing special is done to allow subclasses to call it
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, nibName: nibName)
        setupView()
    }

    // NOTE: update storyboard view
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    // MARK: - IBInspectable

    @IBInspectable var scoredPoints: Double = 0 {
        didSet {
            setupScoredView()
        }
    }

    @IBInspectable var requiredPointsToPass: Double = 0 {
        didSet {
            setupRequiredScoreView()
        }
    }

    @IBInspectable var totalPoints: Double = 0 {
        didSet {
            setupView()
        }
    }

    // MARK: - Methods

    private func setupView() {
        setupPassedStatusView()
        layoutIfNeeded()
    }

    private func setupScoredView() {
        guard scoredPoints >= 0 && scoredPoints <= totalPoints else { return }

        // Update percentage label text
        yourScoreLabel.text = "Your Score: " + String(Int(scoredPoints/totalPoints * 100)) + "%"

        // Move Percentage View
        let desiredWidth = CGFloat(availableValueView.frame.width) * CGFloat(scoredPoints/totalPoints)
        yourScoreViewLeadingConstraint.constant = desiredWidth - yourScoreView.frame.width/2
        currentValueViewWidthConstraint.constant = desiredWidth

        setupView()
    }

    private func setupRequiredScoreView() {
        guard requiredPointsToPass >= 0 && requiredPointsToPass <= totalPoints else { return }

        // Update percentage label text
        requiredScoreLabel.text = "Required Score: " + String(Int(requiredPointsToPass/totalPoints * 100)) + "%"

        // Move Percentage View
        let desiredWidth = CGFloat(availableValueView.frame.width) * CGFloat(requiredPointsToPass/totalPoints)
        requiredScoreViewLeadingConstraint.constant = desiredWidth - requiredScoreView.frame.width/2
        requiredValueViewWidthConstraint.constant = desiredWidth

        setupView()
    }

    private func setupPassedStatusView() {
        if scoredPoints >= requiredPointsToPass {
            passedLabel.isHidden = false
            notPassedLabel.isHidden = true
        } else {
            passedLabel.isHidden = true
            notPassedLabel.isHidden = false
        }

        // Update points label
        actualPointsLabel.text = String(Int(scoredPoints))
        totalPointsLabel.text = String(Int(totalPoints))
    }
}
