<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="4.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <Configuration Condition=" '$(Configuration)' == '' ">Debug</Configuration>
    <Platform Condition=" '$(Platform)' == '' ">AnyCPU</Platform>
    <ProjectGuid>{1dbce6fc-8920-47ed-94ea-8bf9a0c4b31b}</ProjectGuid>
    <OutputType>AppContainerExe</OutputType>
    <AppDesignerFolder>Properties</AppDesignerFolder>
    <RootNamespace>Echoes.Tests.WinRT</RootNamespace>
    <AssemblyName>Echoes.Tests.WinRT</AssemblyName>
    <DefaultLanguage>en-US</DefaultLanguage>
    <ProjectTypeGuids>{BC8A1FFA-BEE3-4634-8014-F334798102B3};{656346D9-4656-40DA-A068-22D5425D4639}</ProjectTypeGuids>
    <PackageCertificateKeyFile>Echoes.Tests.WinRT_TemporaryKey.pfx</PackageCertificateKeyFile>
    <Name>Echoes.Tests.WinRT</Name>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' ">
    <CpuType>AnyCPU</CpuType>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <Optimize>false</Optimize>
    <OutputPath>bin\Debug\</OutputPath>
    <DefineConstants>DEBUG;TRACE;NETFX_CORE</DefineConstants>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' ">
    <CpuType>AnyCPU</CpuType>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <Optimize>true</Optimize>
    <OutputPath>bin\Release\</OutputPath>
    <DefineConstants>TRACE;NETFX_CORE</DefineConstants>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Debug|ARM'">
    <DebugSymbols>true</DebugSymbols>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <OutputPath>bin\ARM\Debug\</OutputPath>
    <DefineConstants>DEBUG;TRACE;NETFX_CORE</DefineConstants>
    <CpuType>ARM</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Release|ARM'">
    <OutputPath>bin\ARM\Release\</OutputPath>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <DefineConstants>TRACE;NETFX_CORE</DefineConstants>
    <Optimize>true</Optimize>
    <CpuType>ARM</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Debug|x64'">
    <DebugSymbols>true</DebugSymbols>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <OutputPath>bin\x64\Debug\</OutputPath>
    <DefineConstants>DEBUG;TRACE;NETFX_CORE</DefineConstants>
    <CpuType>x64</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Release|x64'">
    <OutputPath>bin\x64\Release\</OutputPath>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <DefineConstants>TRACE;NETFX_CORE</DefineConstants>
    <Optimize>true</Optimize>
    <CpuType>x64</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Debug|x86'">
    <DebugSymbols>true</DebugSymbols>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <OutputPath>bin\x86\Debug\</OutputPath>
    <DefineConstants>DEBUG;TRACE;NETFX_CORE</DefineConstants>
    <CpuType>x86</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(Platform)' == 'Release|x86'">
    <OutputPath>bin\x86\Release\</OutputPath>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <DefineConstants>TRACE;NETFX_CORE</DefineConstants>
    <Optimize>true</Optimize>
    <CpuType>x86</CpuType>
    <Prefer32Bit>true</Prefer32Bit>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
  </PropertyGroup>
  <ItemGroup>
    <!-- A reference to the entire .Net Framework and Windows SDK are automatically included -->
    <Folder Include="Assets\" />
    <Folder Include="Common\" />
    <Folder Include="Properties\" />
    <Folder Include="..\Sources\" />
    <Folder Include="..\Sources\Asserts" />
    <Folder Include="..\Sources\InternalTests" />
    <Folder Include="..\Sources\Runner" />
    <Folder Include="..\Sources\Utils" />
  </ItemGroup>
  <ItemGroup>
    <Compile Include="App.xaml.pas">
      <DependentUpon>App.xaml</DependentUpon>
    </Compile>
    <Compile Include="MainPage.xaml.pas">
      <DependentUpon>MainPage.xaml</DependentUpon>
    </Compile>
    <Compile Include="Properties\AssemblyInfo.pas" />
    <Compile Include="..\Sources\Asserts\Assert.pas" />
    <Compile Include="..\Sources\Asserts\BooleanAssert.pas" />
    <Compile Include="..\Sources\Asserts\DoubleAssert.pas" />
    <Compile Include="..\Sources\Asserts\ExceptionAssert.pas" />
    <Compile Include="..\Sources\Asserts\IntegerAssert.pas" />
    <Compile Include="..\Sources\Asserts\Messages.pas" />
    <Compile Include="..\Sources\Asserts\ObjectAssert.pas" />
    <Compile Include="..\Sources\Asserts\SequenceAssert.pas" />
    <Compile Include="..\Sources\Asserts\StringAssert.pas" />
    <Compile Include="..\Sources\Discovery.pas" />
    <Compile Include="..\Sources\InternalTests\EmptyTests.pas" />
    <Compile Include="..\Sources\InternalTests\FailedTests.pas" />
    <Compile Include="..\Sources\Runner\Runner.pas" />
    <Compile Include="..\Sources\Runner\RunnerFailure.pas" />
    <Compile Include="..\Sources\Runner\RunnerListener.pas" />
    <Compile Include="..\Sources\Utils\CodeObject.pas" />
    <Compile Include="..\Sources\Utils\ListenerCapture.pas" />
  </ItemGroup>
  <ItemGroup>
    <AppxManifest Include="Package.appxmanifest">
      <SubType>Designer</SubType>
    </AppxManifest>
    <None Include="Echoes.Tests.WinRT_TemporaryKey.pfx" />
  </ItemGroup>
  <ItemGroup>
    <Content Include="Assets\Logo.png" />
    <Content Include="Assets\WideLogo.png" />
    <Content Include="Assets\SmallLogo.png" />
    <Content Include="Assets\SplashScreen.png" />
    <Content Include="Assets\StoreLogo.png" />
  </ItemGroup>
  <ItemGroup>
    <ApplicationDefinition Include="App.xaml">
      <Generator>MSBuild:Compile</Generator>
      <SubType>Designer</SubType>
    </ApplicationDefinition>
    <Page Include="Common\StandardStyles.xaml">
      <Generator>MSBuild:Compile</Generator>
      <SubType>Designer</SubType>
    </Page>
    <Page Include="MainPage.xaml">
      <Generator>MSBuild:Compile</Generator>
      <SubType>Designer</SubType>
    </Page>
  </ItemGroup>
  <ItemGroup>
    <Reference Include="Sugar">
      <HintPath>C:\Program Files (x86)\RemObjects Software\Oxygene\Sugar\Echoes\WinRT\Sugar.dll</HintPath>
    </Reference>
  </ItemGroup>
  <ItemGroup>
    <ProjectReference Include="..\..\..\RemObjects.Elements.EUnit\RemObjects.Elements.EUnit.Echoes.WinRT.oxygene">
      <Name>RemObjects.Elements.EUnit.Echoes.WinRT</Name>
      <Project>{610fb4ed-d61b-46b1-814c-e9428317bfdd}</Project>
      <Private>True</Private>
      <HintPath>..\..\bin\WinRT\RemObjects.Elements.EUnit.dll</HintPath>
    </ProjectReference>
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
  <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')" />
  <Import Project="$(MSBuildExtensionsPath)\RemObjects Software\Oxygene\RemObjects.Oxygene.Echoes.WinRT.targets" />
  <PropertyGroup>
    <PreBuildEvent />
  </PropertyGroup>
</Project>