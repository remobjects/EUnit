<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="4.0" DefaultTargets="Build">
  <PropertyGroup>
    <Configuration Condition=" '$(Configuration)' == '' ">Debug</Configuration>
    <Platform Condition=" '$(Platform)' == '' ">AnyCPU</Platform>
    <ProjectGuid>610fb4ed-d61b-46b1-814c-e9428317bfdd</ProjectGuid>
    <OutputType>Library</OutputType>
    <AppDesignerFolder>Properties</AppDesignerFolder>
    <RootNamespace>RemObjects.Elements.EUnit</RootNamespace>
    <AssemblyName>RemObjects.Elements.EUnit</AssemblyName>
    <DefaultLanguage>en-US</DefaultLanguage>
    <ProjectTypeGuids>{BC8A1FFA-BEE3-4634-8014-F334798102B3};{656346D9-4656-40DA-A068-22D5425D4639}</ProjectTypeGuids>
    <Name>RemObjects.Elements.EUnit.WinRT</Name>
    <AllowLegacyCreate>False</AllowLegacyCreate>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <Optimize>false</Optimize>
    <OutputPath>bin\WinRT\</OutputPath>
    <DefineConstants>DEBUG;TRACE;NETFX_CORE</DefineConstants>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <Optimize>true</Optimize>
    <OutputPath>bin\WinRT\</OutputPath>
    <DefineConstants>TRACE;NETFX_CORE</DefineConstants>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Debug|ARM'">
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <OutputPath>bin\WinRT\</OutputPath>
    <DefineConstants>DEBUG;TRACE;NETFX_CORE</DefineConstants>
    <CpuType>ARM</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Release|ARM'">
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <OutputPath>bin\WinRT\</OutputPath>
    <DefineConstants>TRACE;NETFX_CORE</DefineConstants>
    <Optimize>true</Optimize>
    <CpuType>ARM</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Debug|x64'">
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <OutputPath>bin\WinRT\</OutputPath>
    <DefineConstants>DEBUG;TRACE;NETFX_CORE</DefineConstants>
    <CpuType>x64</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Release|x64'">
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <OutputPath>bin\WinRT\</OutputPath>
    <DefineConstants>TRACE;NETFX_CORE</DefineConstants>
    <Optimize>true</Optimize>
    <CpuType>x64</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Debug|x86'">
    <GeneratePDB>True</GeneratePDB>
    <DebugSymbols>true</DebugSymbols>
    <OutputPath>bin\WinRT\</OutputPath>
    <DefineConstants>DEBUG;TRACE;NETFX_CORE</DefineConstants>
    <CpuType>x86</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
    <XmlDocWarningLevel>WarningOnPublicMembers</XmlDocWarningLevel>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Release|x86'">
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <OutputPath>bin\WinRT\</OutputPath>
    <DefineConstants>TRACE;NETFX_CORE</DefineConstants>
    <Optimize>true</Optimize>
    <CpuType>x86</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
  </PropertyGroup>
  <ItemGroup>
    <Folder Include="Sources" />
    <Folder Include="Properties\" />
    <Folder Include="Sources\Asserts\Helpers" />
    <Folder Include="Sources\Discovery\WinRT" />
    <Folder Include="Sources\Interfaces" />
    <Folder Include="Sources\Exceptions" />
    <Folder Include="Sources\Internals" />
    <Folder Include="Sources\Internals\Generator" />
    <Folder Include="Sources\Internals\TestNodes" />
    <Folder Include="Sources\Asserts" />
    <Folder Include="Sources\Discovery" />
    <Folder Include="Sources\Utils\Locks" />
    <Folder Include="Sources\Writers" />
    <Folder Include="Sources\Runner" />
    <Folder Include="Sources\Runner\Actions" />
    <Folder Include="Sources\Utils" />
    <Folder Include="Sources\Reflections" />
  </ItemGroup>
  <ItemGroup>
    <Compile Include="Properties\AssemblyInfo_WinRT.pas" />
    <Compile Include="Sources\Asserts\Assert.pas" />
    <Compile Include="Sources\Asserts\BooleanAssert.pas" />
    <Compile Include="Sources\Asserts\DoubleAssert.pas" />
    <Compile Include="Sources\Asserts\ExceptionAssert.pas" />
    <Compile Include="Sources\Asserts\Helpers\ExceptionHelper.pas" />
    <Compile Include="Sources\Asserts\Helpers\SequenceHelper.pas" />
    <Compile Include="Sources\Asserts\IntegerAssert.pas" />
    <Compile Include="Sources\Asserts\ObjectAssert.pas" />
    <Compile Include="Sources\Asserts\SequenceAssert.pas" />
    <Compile Include="Sources\Asserts\StringAssert.pas" />
    <Compile Include="Sources\Discovery\BaseDiscovery.pas" />
    <Compile Include="Sources\Discovery\Discovery.pas" />
    <Compile Include="Sources\Discovery\InstanceDiscovery.pas" />
    <Compile Include="Sources\Discovery\WinRT\AssemblyDiscovery.pas" />
    <Compile Include="Sources\Discovery\WinRT\WinRTDiscovery.pas" />
    <Compile Include="Sources\Discovery\TypeDiscovery.pas" />
    <Compile Include="Sources\Discovery\Validation\IValidator.pas" />
    <Compile Include="Sources\Discovery\Validation\Validator.pas" />
    <Compile Include="Sources\Discovery\Validation\ValidatorExtensions.pas" />
    <Compile Include="Sources\Discovery\Validators\MethodValidators.pas" />
    <Compile Include="Sources\Discovery\Validators\TypeValidators.pas" />
    <Compile Include="Sources\Exceptions\ArgumentException.pas" />
    <Compile Include="Sources\Exceptions\ArgumentNilException.pas" />
    <Compile Include="Sources\Exceptions\AssertException.pas" />
    <Compile Include="Sources\Exceptions\BaseException.pas" />
    <Compile Include="Sources\Exceptions\InvalidOperationException.pas" />
    <Compile Include="Sources\Exceptions\RunnerException.pas" />
    <Compile Include="Sources\Interfaces\Aliases.pas" />
    <Compile Include="Sources\Interfaces\Blocks.pas" />
    <Compile Include="Sources\Interfaces\Extensions.pas" />
    <Compile Include="Sources\Interfaces\IAsyncResult.pas" />
    <Compile Include="Sources\Interfaces\IAwaitToken.pas" />
    <Compile Include="Sources\Interfaces\ICancelationToken.pas" />
    <Compile Include="Sources\Interfaces\IDiscovery.pas" />
    <Compile Include="Sources\Interfaces\IEventListener.pas" />
    <Compile Include="Sources\Interfaces\ITest.pas" />
    <Compile Include="Sources\Interfaces\ITestResult.pas" />
    <Compile Include="Sources\Interfaces\TestKind.pas" />
    <Compile Include="Sources\Interfaces\TestState.pas" />
    <Compile Include="Sources\Internals\AsyncResult.pas" />
    <Compile Include="Sources\Internals\ErrorMessage.pas" />
    <Compile Include="Sources\Internals\Generator\Hasher.pas" />
    <Compile Include="Sources\Internals\Generator\IdGenerator.pas" />
    <Compile Include="Sources\Internals\RunContext.pas" />
    <Compile Include="Sources\Internals\TestNodes\TestcaseNode.pas" />
    <Compile Include="Sources\Internals\TestNodes\TestClassNode.pas" />
    <Compile Include="Sources\Internals\TestNodes\TestNode.pas" />
    <Compile Include="Sources\Internals\TestNodes\TestSuiteNode.pas" />
    <Compile Include="Sources\Internals\TestResultNode.pas" />
    <Compile Include="Sources\Reflections\Method.pas" />
    <Compile Include="Sources\Reflections\Type.pas" />
    <Compile Include="Sources\Runner\Actions\BaseAction.pas" />
    <Compile Include="Sources\Runner\Actions\BlockAction.pas" />
    <Compile Include="Sources\Runner\Actions\InitializeInstanceAction.pas" />
    <Compile Include="Sources\Runner\Actions\InitializeMethodAction.pas" />
    <Compile Include="Sources\Runner\Actions\InitializeTypeAction.pas" />
    <Compile Include="Sources\Runner\Actions\InstanceAction.pas" />
    <Compile Include="Sources\Runner\Actions\MethodAction.pas" />
    <Compile Include="Sources\Runner\Actions\ResultAction.pas" />
    <Compile Include="Sources\Runner\Actions\SetupAction.pas" />
    <Compile Include="Sources\Runner\Actions\TeardownAction.pas" />
    <Compile Include="Sources\Runner\Actions\TeardownTestAction.pas" />
    <Compile Include="Sources\Runner\Actions\SetupTestAction.pas" />
    <Compile Include="Sources\Runner\Actions\TryFinallyAction.pas" />
    <Compile Include="Sources\Runner\Runner.pas" />
    <Compile Include="Sources\Test.pas" />
    <Compile Include="Sources\Utils\ConsoleTestListener.pas" />
    <Compile Include="Sources\Utils\Tokens\AwaitToken.pas" />
    <Compile Include="Sources\Utils\Tokens\CancelationToken.pas" />
    <Compile Include="Sources\Utils\Tokens\TokenProvider.pas" />
    <Compile Include="Sources\Utils\Locks\AbstractLock.pas" />
    <Compile Include="Sources\Utils\Locks\ExceptionLock.pas" />
    <Compile Include="Sources\Utils\Locks\Lock.pas" />
    <Compile Include="Sources\Utils\Locks\ResultLock.pas" />
    <Compile Include="Sources\Writers\BaseWriter.pas" />
    <Compile Include="Sources\Writers\ConsoleWriter.pas" />
    <Compile Include="Sources\Writers\StringWriter.pas" />
    <Compile Include="Sources\Writers\Summary.pas" />
  </ItemGroup>
  <PropertyGroup Condition=" '$(VisualStudioVersion)' == '' or '$(VisualStudioVersion)' &lt; '11.0' ">
    <VisualStudioVersion>11.0</VisualStudioVersion>
  </PropertyGroup>
  <!-- To modify your build process, add your task inside one of the targets below and uncomment it. 
       Other similar extension points exist, see Microsoft.Common.targets.
  <Target Name="BeforeBuild">
  </Target>
  <Target Name="AfterBuild">
  </Target>
  -->
  <ItemGroup>
    <Reference Include="mscorlib" />
    <Reference Include="Windows" />
    <Reference Include="Sugar" />
    <Reference Include="System.Net.Http" />
    <Reference Include="System.Xml" />
    <Reference Include="System.Xml.Linq" />
    <Reference Include="System.Xml.ReaderWriter" />
    <Reference Include="System.Reflection" />
    <Reference Include="System.Reflection.Extensions" />
    <Reference Include="System.Runtime" />
    <Reference Include="System.Runtime.InteropServices" />
    <Reference Include="System.Globalization" />
    <Reference Include="System.Runtime.WindowsRuntime" />
    <Reference Include="System.Threading" />
    <Reference Include="System.Threading.Tasks" />
    <Reference Include="System.IO" />
    <Reference Include="System.Linq" />
    <Reference Include="System.Collections" />
    <Reference Include="System.Text.Encoding" />
    <Reference Include="System.Diagnostics.Debug" />
    <Reference Include="System.Runtime.Extensions" />
  </ItemGroup>
  <Import Project="$(MSBuildExtensionsPath)\RemObjects Software\Sugar\Microsoft.Windows.UI.Xaml.Oxygene.targets" />
  <PropertyGroup>
    <PreBuildEvent>rmdir /s /q $(ProjectDir)\Obj</PreBuildEvent>
  </PropertyGroup>
</Project>