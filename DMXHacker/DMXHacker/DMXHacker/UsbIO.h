//
//  UsbIO.h
//  ShowJockey
//
//  Created by randywind on 10/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

/**********************************************************************
 Class : UsbIO
 Author : Ligine
 Date: 10.11.2012
 Version : 1.0
 Routines to Proivde ShowJockey Client Device Applicate Interface
 
 1. Verify getShowJockeyDeviceBuf Interface
 
 ***********************************************************************/


#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

#include <IOKit/IOKitLib.h>
#include <IOKit/IOMessage.h>
#include <IOKit/IOCFPlugIn.h>
#include <IOKit/usb/IOUSBLib.h>
#import <unistd.h>

@interface showJockeyDevice : NSObject {
    IOUSBDeviceInterface245 **showJockeyDev;     // Usb设备
    IOUSBInterfaceInterface245 **showJockeyIntf;	// Usb接口
    UInt8  pipeIn;       // 输入
    UInt8  pipeOut;      // 输出
    UInt32 deviceID;
    UInt16 maxPacketSizeIn;
    UInt16 maxPacketSizeOut;
    UInt8  deviceMode;
    
}

@property(nonatomic,assign) IOUSBDeviceInterface245 **showJockeyDev;     // Usb设备
@property(nonatomic,assign) IOUSBInterfaceInterface245 **showJockeyIntf;	// Usb接口
@property(nonatomic,assign) UInt8 pipeIn;       // 输入
@property(nonatomic,assign) UInt8 pipeOut;      // 输出
@property(nonatomic,assign) UInt32 deviceID;    // 设备标识
@property(nonatomic,assign) UInt16 maxPacketSizeIn;
@property(nonatomic,assign) UInt16 maxPacketSizeOut; 
@property(nonatomic,assign) UInt8   deviceMode;//
@end


/*!
    @protocol	 showJockeyDeviceDelegate
    @abstract    
    @discussion  It is notified when the device status changed
				 such as a new device found , or a device remove
*/
@protocol showJockeyDeviceDelegate

/*!
    @method     addDeviceNotify:
    @abstract   
    @discussion 
	@param      device The new find device
*/
- (void)addDeviceNotify:(showJockeyDevice *)device;

/*!
    @method     removeDeviceNotify:
    @abstract   
    @discussion 
	@param		device The remove device
*/
- (void)removeDeviceNotify:(showJockeyDevice *)device;
@end


/*!
    @class			UsbIO
    @abstract    
    @discussion  
	
*/

@interface UsbIO : NSObject {
	NSMutableArray *showJockeyDevices;   // 设备集合
	NSThread *monitorThread;
	id<showJockeyDeviceDelegate> delegate;
	
	UInt32 PID;
	UInt32 VID;
}

@property (nonatomic,retain) NSMutableArray *showJockeyDevices;
@property (nonatomic,assign) id<showJockeyDeviceDelegate>delegate;

/*!
    @method     getDllVersion
    @abstract   Get current dll verison
    @discussion 
	@result     Dll version characters
*/
- (NSString *)getDllVersion;

/*!
    @method    setShowJockeyDeviceInfo:andVid: 
    @abstract  Set the device info like pid and vid
    @discussion 
	@param	   pid The device product id
	@param	   vid The device vendor  id
*/
- (void)setShowJockeyDeviceInfo:(UInt32)pid andVid:(UInt32)vid;

/*!
 @method    scanShowJockeyDevices 
 @abstract  Scan all the device
 @discussion 
 @result	kIOReturnSuccess , other fail
 */
- (IOReturn)scanShowJockeyDevices;

/*!
 @method    getShowJockeyDeviceCount 
 @abstract  Get the amount of the devices 
 @discussion 
 @result	The amount of the devices
 */
- (UInt)getShowJockeyDeviceCount;

/*!
 @method    openShowJockeyDevice: 
 @abstract  Open the device
 @discussion
 @param		dev The device wanted to open
 @result	true,Open success;false Open fail
 */
- (BOOL)openShowJockeyDevice:(showJockeyDevice *)dev;

/*!
 @method    closeShowJockeyDevice: 
 @abstract  Close the device
 @discussion 
 @param		dev The device wanted to close
 @result	true, Close success ; false, Close fail
 */
- (BOOL)closeShowJockeyDevice:(showJockeyDevice *)dev;

/*!
 @method    getShowJockeyDevice: 
 @abstract  Get the device
 @discussion 
 @param		devIndex The device index
 @result	The destination device
 */
- (showJockeyDevice *)getShowJockeyDevice:(UInt8)devIndex;

/*!
 @method    getShowJockeyDeviceMode: 
 @abstract  Get the device mode (type)
 @discussion 
 @param		dev The device wanted to get its mode
 @result	The device mode (type)
 */
- (UInt8)getShowJockeyDeviceMode:(showJockeyDevice *)dev;

/*!
 @method    getShowJockeyDeviceBuf:andBuffer:andSize:
 @abstract	Get buffer from the device
 @discussion 
 @param		dev The device for getting buffer from
 @param		buf The buffer wanted to fill in
 @param		pSize  When in,it is the buffer length;When out, it is the buffer fill length
 @result	kIOReturnSuccess , other fail
 */
- (IOReturn)getShowJockeyDeviceBuf:(showJockeyDevice *)dev andBuffer:(Byte *)buf andSize:(UInt32 *)pSize;

/*!
 @method    sendShowJockeyDeviceBuf:andBuffer:andSize: 
 @abstract  Send buffer to the device
 @discussion 
 @param		dev The device for sending buffer to
 @param		buf The buffer wanted to send
 @param		size The buffer length
 @result	kIOReturnSuccess , other fail
 */
- (IOReturn)sendShowJockeyDeviceBuf:(showJockeyDevice *)dev andBuffer:(Byte *)buf andSize:(UInt32)size;

@end
