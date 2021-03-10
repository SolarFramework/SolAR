
#include <xpcf/module/ModuleFactory.h>
#include <iostream>

namespace xpcf=org::bcom::xpcf;

/**
 *  @ingroup xpcfmodule
 */
/**
  * Declare module.
  */
XPCF_DECLARE_MODULE("{5b697945-796d-4e10-9bc6-9380960c2a42}","SolAR::MODULES::SolARModuleColmap","SolARModuleColmap module description");

/**
 * This method is the module entry point.
 * XPCF uses this method to create components available in the module.
 *
 * Each component exposed must be declared inside a xpcf::tryCreateComponent<ComponentType>() call.
 */
extern "C" XPCF_MODULEHOOKS_API xpcf::XPCFErrorCode XPCF_getComponent(const xpcf::uuids::uuid& componentUUID,SRef<xpcf::IComponentIntrospect>& interfaceRef)
{
    xpcf::XPCFErrorCode errCode = xpcf::XPCFErrorCode::_FAIL;
    errCode = xpcf::tryCreateComponent<SolAR::MODULES::SolARModuleColmap::componentType>(componentUUID,interfaceRef);
    if (errCode != xpcf::XPCFErrorCode::_SUCCESS) {
        errCode = xpcf::tryCreateComponent<SolAR::MODULES::SolARModuleColmap::otherComponentType>(componentUUID,interfaceRef);
    }
    return errCode;
}

/**
  * The declarations below populate list of the components available in the module (it represents the module index).
  * XPCF uses this index to introspect the components available in a module, providing the ability to generate the configuration file skeleton from the code.
  */
XPCF_BEGIN_COMPONENTS_DECLARATION
XPCF_ADD_COMPONENT(SolAR::MODULES::SolARModuleColmap::componentType)
XPCF_ADD_COMPONENT(SolAR::MODULES::SolARModuleColmap::otherComponentType)
XPCF_END_COMPONENTS_DECLARATION
