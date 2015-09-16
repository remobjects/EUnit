<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Build" ToolsVersion="4.0">
    <PropertyGroup>
        <RootNamespace>RemObjects.Elements.EUnit</RootNamespace>
        <ProjectGuid>{18e41908-be34-4c8c-9cd8-732c692d93a5}</ProjectGuid>
        <OutputType>StaticLibrary</OutputType>
        <AssemblyName>EUnit</AssemblyName>
        <AllowGlobals>False</AllowGlobals>
        <AllowLegacyWith>False</AllowLegacyWith>
        <AllowLegacyOutParams>False</AllowLegacyOutParams>
        <AllowLegacyCreate>False</AllowLegacyCreate>
        <AllowUnsafeCode>False</AllowUnsafeCode>
        <Configuration Condition="'$(Configuration)' == ''">Release</Configuration>
        <SDK>OS X</SDK>
        <CreateHeaderFile>True</CreateHeaderFile>
        <Name>RemObjects.Elements.EUnit (OS X)</Name>
        <GenerateDebugInfo>True</GenerateDebugInfo>
    </PropertyGroup>
    <PropertyGroup Condition=" '$(Configuration)' == 'Debug' ">
        <Optimize>False</Optimize>
        <OutputPath>bin\Debug\</OutputPath>
        <DefineConstants>DEBUG;TRACE;</DefineConstants>
        <CaptureConsoleOutput>False</CaptureConsoleOutput>
        <XmlDocWarningLevel>WarningOnPublicMembers</XmlDocWarningLevel>
    </PropertyGroup>
    <PropertyGroup Condition=" '$(Configuration)' == 'Release' ">
        <Optimize>true</Optimize>
        <OutputPath>.\bin\Release</OutputPath>
        <TreatWarningsAsErrors>False</TreatWarningsAsErrors>
        <CaptureConsoleOutput>False</CaptureConsoleOutput>
        <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
    </PropertyGroup>
    <ItemGroup>
        <Reference Include="Foundation.fx"/>
        <Reference Include="libSugar.fx"/>
        <Reference Include="libxml2.fx"/>
        <Reference Include="rtl.fx"/>
        <Reference Include="libNougat.fx"/>
    </ItemGroup>
    <ItemGroup>
        <Compile Include="Sources\Asserts\Assert.pas"/>
        <Compile Include="Sources\Asserts\BooleanAssert.pas"/>
        <Compile Include="Sources\Asserts\DoubleAssert.pas"/>
        <Compile Include="Sources\Asserts\ExceptionAssert.pas"/>
        <Compile Include="Sources\Asserts\Helpers\ExceptionHelper.pas"/>
        <Compile Include="Sources\Asserts\Helpers\SequenceHelper.pas"/>
        <Compile Include="Sources\Asserts\IntegerAssert.pas"/>
        <Compile Include="Sources\Asserts\ObjectAssert.pas"/>
        <Compile Include="Sources\Asserts\SequenceAssert.pas"/>
        <Compile Include="Sources\Asserts\StringAssert.pas"/>
        <Compile Include="Sources\Discovery\BaseDiscovery.pas"/>
        <Compile Include="Sources\Discovery\Discovery.pas"/>
        <Compile Include="Sources\Discovery\InstanceDiscovery.pas"/>
        <Compile Include="Sources\Discovery\Nougat\ModuleDiscovery.pas"/>
        <Compile Include="Sources\Discovery\Nougat\NougatDiscovery.pas"/>
        <Compile Include="Sources\Discovery\TypeDiscovery.pas"/>
        <Compile Include="Sources\Discovery\Validation\IValidator.pas"/>
        <Compile Include="Sources\Discovery\Validation\Validator.pas"/>
        <Compile Include="Sources\Discovery\Validation\ValidatorExtensions.pas"/>
        <Compile Include="Sources\Discovery\Validators\MethodValidators.pas"/>
        <Compile Include="Sources\Discovery\Validators\TypeValidators.pas"/>
        <Compile Include="Sources\Exceptions\ArgumentException.pas"/>
        <Compile Include="Sources\Exceptions\ArgumentNilException.pas"/>
        <Compile Include="Sources\Exceptions\AssertException.pas"/>
        <Compile Include="Sources\Exceptions\BaseException.pas"/>
        <Compile Include="Sources\Exceptions\InvalidOperationException.pas"/>
        <Compile Include="Sources\Exceptions\RunnerException.pas"/>
        <Compile Include="Sources\Interfaces\Aliases.pas"/>
        <Compile Include="Sources\Interfaces\Blocks.pas"/>
        <Compile Include="Sources\Interfaces\Extensions.pas"/>
        <Compile Include="Sources\Interfaces\IAsyncResult.pas"/>
        <Compile Include="Sources\Interfaces\IAwaitToken.pas"/>
        <Compile Include="Sources\Interfaces\ICancelationToken.pas"/>
        <Compile Include="Sources\Interfaces\IDiscovery.pas"/>
        <Compile Include="Sources\Interfaces\IEventListener.pas"/>
        <Compile Include="Sources\Interfaces\ITest.pas"/>
        <Compile Include="Sources\Interfaces\ITestResult.pas"/>
        <Compile Include="Sources\Interfaces\TestKind.pas"/>
        <Compile Include="Sources\Interfaces\TestState.pas"/>
        <Compile Include="Sources\Internals\AsyncResult.pas"/>
        <Compile Include="Sources\Internals\ErrorMessage.pas"/>
        <Compile Include="Sources\Internals\Generator\Hasher.pas"/>
        <Compile Include="Sources\Internals\Generator\IdGenerator.pas"/>
        <Compile Include="Sources\Internals\RunContext.pas"/>
        <Compile Include="Sources\Internals\TestNodes\TestcaseNode.pas"/>
        <Compile Include="Sources\Internals\TestNodes\TestClassNode.pas"/>
        <Compile Include="Sources\Internals\TestNodes\TestNode.pas"/>
        <Compile Include="Sources\Internals\TestNodes\TestSuiteNode.pas"/>
        <Compile Include="Sources\Internals\TestResultNode.pas"/>
        <Compile Include="Sources\Reflections\Method.pas"/>
        <Compile Include="Sources\Reflections\Type.pas"/>
        <Compile Include="Sources\Runner\Actions\BaseAction.pas"/>
        <Compile Include="Sources\Runner\Actions\BlockAction.pas"/>
        <Compile Include="Sources\Runner\Actions\InitializeInstanceAction.pas"/>
        <Compile Include="Sources\Runner\Actions\InitializeMethodAction.pas"/>
        <Compile Include="Sources\Runner\Actions\InitializeTypeAction.pas"/>
        <Compile Include="Sources\Runner\Actions\InstanceAction.pas"/>
        <Compile Include="Sources\Runner\Actions\MethodAction.pas"/>
        <Compile Include="Sources\Runner\Actions\ResultAction.pas"/>
        <Compile Include="Sources\Runner\Actions\SetupAction.pas"/>
        <Compile Include="Sources\Runner\Actions\TeardownAction.pas"/>
        <Compile Include="Sources\Runner\Actions\TeardownTestAction.pas"/>
        <Compile Include="Sources\Runner\Actions\SetupTestAction.pas"/>
        <Compile Include="Sources\Runner\Actions\TryFinallyAction.pas"/>
        <Compile Include="Sources\Runner\Runner.pas"/>
        <Compile Include="Sources\Test.pas"/>
        <Compile Include="Sources\Utils\ConsoleTestListener.pas"/>
        <Compile Include="Sources\Utils\Tokens\AwaitToken.pas"/>
        <Compile Include="Sources\Utils\Tokens\CancelationToken.pas"/>
        <Compile Include="Sources\Utils\Tokens\TokenProvider.pas"/>
        <Compile Include="Sources\Utils\Locks\AbstractLock.pas"/>
        <Compile Include="Sources\Utils\Locks\ExceptionLock.pas"/>
        <Compile Include="Sources\Utils\Locks\Lock.pas"/>
        <Compile Include="Sources\Utils\Locks\ResultLock.pas"/>
        <Compile Include="Sources\Writers\BaseWriter.pas"/>
        <Compile Include="Sources\Writers\ConsoleWriter.pas"/>
        <Compile Include="Sources\Writers\StringWriter.pas"/>
        <Compile Include="Sources\Writers\Summary.pas"/>
    </ItemGroup>
    <ItemGroup>
        <Folder Include="Properties\"/>
        <Folder Include="Sources"/>
        <Folder Include="Sources\Asserts\Helpers"/>
        <Folder Include="Sources\Discovery\Nougat"/>
        <Folder Include="Sources\Discovery\Validation\"/>
        <Folder Include="Sources\Discovery\Validators\"/>
        <Folder Include="Sources\Interfaces"/>
        <Folder Include="Sources\Exceptions"/>
        <Folder Include="Sources\Internals"/>
        <Folder Include="Sources\Internals\Generator"/>
        <Folder Include="Sources\Internals\TestNodes"/>
        <Folder Include="Sources\Asserts"/>
        <Folder Include="Sources\Discovery"/>
        <Folder Include="Sources\Utils\Locks"/>
        <Folder Include="Sources\Utils\Tokens\"/>
        <Folder Include="Sources\Writers"/>
        <Folder Include="Sources\Runner"/>
        <Folder Include="Sources\Runner\Actions"/>
        <Folder Include="Sources\Utils"/>
        <Folder Include="Sources\Reflections"/>
    </ItemGroup>
    <Import Project="$(MSBuildExtensionsPath)/RemObjects Software/Oxygene/RemObjects.Oxygene.Nougat.targets"/>
    <PropertyGroup>
        <PreBuildEvent/>
    </PropertyGroup>
</Project>