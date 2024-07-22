using SimpleImageViewer;

namespace Drastic.SimpleImageViewer.Sample;

[Register ("AppDelegate")]
public class AppDelegate : UIApplicationDelegate {
	public override UIWindow? Window {
		get;
		set;
	}

	public override bool FinishedLaunching (UIApplication application, NSDictionary launchOptions)
	{
		// create a new window instance based on the screen size
		Window = new UIWindow (UIScreen.MainScreen.Bounds);

		// create a UIViewController with a single UILabel
		var vc = new TestViewController ();
		Window.RootViewController = vc;

		// make the window visible
		Window.MakeKeyAndVisible ();

		return true;
	}
}

public class TestViewController : UIViewController
{
	public override void ViewDidLoad()
	{
		var button = new UIButton (new CGRect (150, 150, 60, 40));
		button.SetTitle ("Image", UIControlState.Normal);
		button.BackgroundColor = UIColor.Red;
		button.SetTitleColor (UIColor.Black, UIControlState.Normal);
		var imageView = new UIImageView (new CGRect(0, 200, 300, 300))
		{
			Image = UIImage.LoadFromData(NSData.FromArray(Convert.FromBase64String("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"))),
			ContentMode = UIViewContentMode.ScaleAspectFit
		};
		View.AddSubview (button);

		View.AddSubview (imageView);
		button.TouchUpInside += (sender, e) =>
		{
				
			var configuration = new ImageViewerConfiguration ((ImageViewerConfiguration obj) =>
			{
				obj.ImageView = imageView;
			});
			var imageViewController = new ImageViewerController (configuration);
			var subviews = imageViewController.View.Subviews;
			PresentViewController (imageViewController, true, null);
		};
	}
}
