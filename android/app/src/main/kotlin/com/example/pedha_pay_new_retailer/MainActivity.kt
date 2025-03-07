package com.app.pedhapay

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.sql.DriverManager.println

class MainActivity: FlutterActivity() {

    private val CHANNEL = "pedhapay/aeps"

    private var callResult: MethodChannel.Result? = null
    private var kyc :Boolean = false

    private val pidMorpho =
            "<PidOptions ver=\"1.0\"><Opts fCount=\"1\" fType=\"2\" iCount=\"0\" iType=\"\" pCount=\"0\" pType=\"\" format=\"0\" pidVer=\"2.0\" timeout=\"10000\" otp=\"\"  posh=\"UNKNOWN\" env=\"P\"/></PidOptions>"
    private val pidMantra =
            "<PidOptions ver=\"1.0\"><Opts env=\"P\" fCount=\"1\" fType=\"2\" iCount=\"0\" format=\"0\"pidVer=\"2.0\" timeout=\"15000\" wadh=\"\"posh=\"UNKNOWN\" /></PidOptions>"
    private val pidStartek =
            "<PidOptions ver=\"1.0\"> <Opts fCount=\"1\" fType=\"2\" iCount=\"0\" pCount=\"0\" format=\"0\" pidVer=\"2.0\" timeout=\"10000\"  env=\"P\" wadh=\"E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc=\"/><Demo></Demo> <CustOpts><Param name=\"Param1\" value=\"\" /></CustOpts> </PidOptions>"
    private val pidEvolute =
            "<PidOptions ver =\"1.0\"><Opts env=\"P\" fCount=\"1\" fType=\"2\" iCount=\"1\" iType=\"0\" pCount=\"1\" pType=\"0\" format=\"0\" pidVer=\"2.0\" timeout=\"10000\" otp=\"\" wadh=\"E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc=\" posh=\"UNKNOWN\"/> <Demo></Demo> <CustOpts> <Param name=\"Param1\" value=\"\"/>  </CustOpts></PidOptions>"

    private val pidEvoluteWadh =
            "<PidOptions ver=\"1.0\"><Opts env=\"P\" fCount=\"1\" fType=\"2\" iCount=\"0\" format=\"0\"pidVer=\"2.0\" timeout=\"15000\" wadh=\"E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc=\"posh=\"UNKNOWN\" /></PidOptions>"

    private val pidprecision =
            "<PidOptions ver=\"1.0\"><Opts env=\"P\" fCount=\"1\" fType=\"2\" iCount=\"0\" format=\"0\"pidVer=\"2.0\" timeout=\"15000\" wadh=\"E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc=\"posh=\"UNKNOWN\" /></PidOptions>"

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if(requestCode == 2 && resultCode == Activity.RESULT_OK){
            if(data!=null && callResult!=null)
            {
                var pidData = data.getStringExtra("PID_DATA")

                callResult?.success(pidData);


            }else{
                callResult?.success("User Cancelled");
                println("User Cancelled")
            }

        }

    }




    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            // This method is invoked on the main thread.

            // TODO
            callResult = result

            if(call.method != "credo" &&  call.method != "cmsFing") {
                val argUrl: String? = call.argument("url")
                kyc = argUrl!!.isNotEmpty()
                println("mkcdnsvd jnsj  "+kyc)
                println(call.method)
            }

            if(call.method == "morpho"){
                val intent2 = Intent()
                intent2.action = "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("com.scl.rdservice")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidMorpho})
                startActivityForResult(intent2, 2)

            }else if(call.method == "morphol1"){
                val intent2 = Intent()
                intent2.action = "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("com.idemia.l1rdservice")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidMorpho})
                startActivityForResult(intent2, 2)

            }else if(call.method == "mantra"){
                val intent2 = Intent()
                intent2.action = "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("com.mantra.rdservice")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidMantra})
                startActivityForResult(intent2, 2)

            }else if(call.method == "mantral1"){
//                val argUrl: String? = call.argument("url")
//                kyc = argUrl!!.isNotEmpty()
                val intent2 = Intent()
                intent2.action = "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("com.mantra.mfs110.rdservice")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidMantra})
                startActivityForResult(intent2, 2)

            }
            else if(call.method == "startek"){
                val intent2 = Intent()
                intent2.action = "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("com.acpl.registersdk")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidStartek})
                startActivityForResult(intent2, 2)

            }else if(call.method == "startekl1"){
                val intent2 = Intent()
                intent2.action = "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("com.acpl.registersdk_l1")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidStartek})
                startActivityForResult(intent2, 2)

            }
            else if(call.method == "aratek"){
                val intent2 = Intent()
                intent2.action= "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("co.aratek.asix_gms.rdservice")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidMantra})
                startActivityForResult(intent2, 2)

            }
            else if(call.method == "evolute"){
                val intent2 = Intent()
                intent2.action = "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("com.evolute.rdservice")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidEvolute})
                startActivityForResult(intent2, 2)

            }else if(call.method == "secugen"){
                val intent2 = Intent()
                intent2.action = "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("com.secugen.rdservice")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidEvolute})
                startActivityForResult(intent2, 2)

            }else if(call.method == "next biometrics"){
                val intent2 = Intent()
                intent2.action = "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("com.nextbiometrics.rdservice")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidEvolute})
                startActivityForResult(intent2, 2)

            }else if(call.method == "precision"){

                val intent2 = Intent()
                intent2.action = "in.gov.uidai.rdservice.fp.CAPTURE"
                intent2.setPackage("com.precision.pb510.rdservice")
                intent2.putExtra("PID_OPTIONS", if(kyc){pidEvoluteWadh}else{pidprecision})
                startActivityForResult(intent2, 2)
            }

        }
    }

}
