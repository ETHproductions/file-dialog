import lime.ui.FileDialog;
import lime.system.System;
import haxe.io.Bytes;

class FileUtils {

	public static function openFile(options:Dynamic):Void {
		var dialog = new FileDialog();
		
		if (Reflect.hasField(options, "oncancel")) {
			dialog.onCancel.add(function() {
				Reflect.field(options, "oncancel")();
			});
		}
		
		if (Reflect.hasField(options, "onsubmit")) {
			dialog.onOpen.add(function(filedata) {
				Reflect.field(options, "onsubmit")(Std.string(filedata));
			});
		}
		
		dialog.open(Reflect.field(options, "filter"), Reflect.field(options, "path"), Reflect.field(options, "title"));
	}

	public static function saveFile(data:String, options:Dynamic):Void {
		var dialog = new FileDialog();
		if (Reflect.hasField(options, "oncancel"))
			dialog.onCancel.add(function() {
				Reflect.field(options, "oncancel")();
			});
		if (Reflect.hasField(options, "onsubmit"))
			dialog.onSave.add(function(filepath) {
				Reflect.field(options, "onsubmit")(filepath);
			});
		dialog.save(Bytes.ofString(data), Reflect.field(options, "filter"), Reflect.field(options, "path"), Reflect.field(options, "title"));
	}
	
	public static function getDirectory(which:String) {
		return Reflect.field(lime.system.System, which);
	}
}
