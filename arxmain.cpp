//
// Arx entry for 'ClipboardManager' project.
//

#if defined(_DEBUG) && !defined(AC_FULL_DEBUG)
#error _DEBUG should not be defined except in internal Adesk debug builds
#endif

#include <aced.h>
#include <rxregsvc.h>

#pragma mark -
#pragma mark define command runner 

extern void startClipManagerPlugin();
extern void endClipManagerPlugin();
extern void toggleClipManagerWindow();

#pragma mark -
#pragma mark standard arx setup

void initApp()
{
	startClipManagerPlugin();
    acedRegCmds->addCommand(L"CLIPBOARD_COMMANDS", L"clipmgr", L"clipmgr", ACRX_CMD_TRANSPARENT, toggleClipManagerWindow);
}

void unloadApp()
{
	endClipManagerPlugin();
    acedRegCmds->removeGroup(L"CLIPBOARD_COMMANDS");
}

// ARX entry point
extern "C"
AcRx::AppRetCode acrxEntryPoint(AcRx::AppMsgCode msg, void* appId)
{
    switch (msg) {
    case AcRx::kInitAppMsg:
        acrxDynamicLinker->unlockApplication(appId);
		acrxDynamicLinker->registerAppMDIAware(appId);
        initApp();
        break;
    case AcRx::kUnloadAppMsg:
        unloadApp();
    }
    return AcRx::kRetOK;
}



