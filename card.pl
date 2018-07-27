#Template Name--CS / 400G WDM OTN 10x QSFP+ 2x CFP2 (NCS4K-4H-OPW-QC2=)
##Shelf Applicable--4016 4009
##Manufacturer--CISCO
##Part Number--NCS4K-4H-OPW-QC2=
##Material ID--11324941
##SAP Code--10783542
##CLEI-7--WOTRD5A
##Category/Card Type--400G WDM OTN
##Face Label/Model Name--400G WDM OTN
##Card AID Formula--LC-<SHELF>-<SLOT>
##Status--PRE_INVENTORY
##Description--400G WDM OTN 10x QSFP+ 2x CFP2 (NCS4K-4H-OPW-QC2=)
##Slot Occupancy--1
##Card Type--Container
##Number Of Ports--0
##Height--11.05
##Width--1.55
##Depth--17.7
##Traffic Bearing (Y/N)--Y
#
use strict;
use Data::UUID;

my $header = <STDIN>;
my $card = <STDIN>;
my %cardnvp ;
print $header;
print $card;

my @headerp = split (",",$header);
my @cardp = split (",",$card);

my $i;
for ($i=0;$i<$#headerp;$i++)
{
  printf "#%s--%s\n", $headerp[$i],$cardp[$i];
  $cardnvp{$headerp[$i]} = $cardp[$i];
}

my $ug = Data::UUID->new;

my $equipmentuuid =  $ug->create_str();
my $spatialuuid =  $ug->create_str();
my $equipment = qq  ( 

  <equipment xmlns="urn:onf:params:xml:ns:yang:core-model">
    <uuid>$equipmentuuid</uuid>
    <connector/>
    <contained-holder/>
    <addressed-by-holder/>
    <encapsulated-non-fru/>
    <exposed-cable/>
    <manufactured-thing>$cardnvp{'Part Number'}</manufactured-thing>
    <spatial-properties-of-type>$spatialuuid</spatial-properties-of-type>
    <mechanical-features/>
    <physical-properties/>
    <!--<function-enablers/>-->
    <mechanical-functions/>
    <physical-characteristics/>
    <swapability/>
    <structure>equipment-category-circuit_pack</structure>
    <environmental-rating/>
    <non-fru-support-position/>
    <!--<function-block/>-->
    <expected-equipment/>
    <actual-equipment/>
    <location/>
    <!--<foundation-pc/>-->
    <local-id>
      <value-name/>
      <value/>
      <name-and-value-authority/>
    </local-id>
    <name>
      <value-name>Template Name</value-name>
      <value>$cardnvp{'Template Name'}</value>
      <name-and-value-authority/>
    </name>
    <name>
      <value-name>Card AID Formula</value-name>
      <value><![CDATA[
               $cardnvp{'Card AID Formula'}        
	       ]]></value>
      <name-and-value-authority/>
    </name>
    <name>
      <value-name>Traffic Bearing (Y/N)</value-name>
      <value>$cardnvp{'Traffic Bearing (Y/N)'}</value>
      <name-and-value-authority/>
    </name>
    <name>
      <value-name>Card Type</value-name>
      <value>$cardnvp{'Card Type'}</value>
      <name-and-value-authority/>
    </name>
    <label>
      <value-name/>
      <value/>
      <name-and-value-authority/>
    </label>
    <extension>
      <value-name/>
      <value/>
      <name-and-value-authority/>
    </extension>
    <operational-state>operational-state-disabled</operational-state>
    <administrative-control>administrative-control-quiescent</administrative-control>
    <administrative-state>administrative-state-locked</administrative-state>
    <lifecycle-state>lifecycle-state-installed</lifecycle-state>
</equipment>
  <spatial-properties-of-type xmlns="urn:onf:params:xml:ns:yang:core-model">
          <uuid>$spatialuuid</uuid>
          <height>$cardnvp{'Height'}</height>
          <width>$cardnvp{'Width'}</width>
          <length>$cardnvp{'Depth'}</length>
    <local-id>
      <value-name/>
      <value/>
      <name-and-value-authority/>
    </local-id>
    <name>
            <value-name>weight</value-name>
            <value>$cardnvp{'Weight'}</value>
      <name-and-value-authority/>
    </name>
    <name>
            <value-name>Dim to Base</value-name>
            <value>$cardnvp{'Dim to Base'}</value>
      <name-and-value-authority/>
    </name>
    <name>
            <value-name>Dim to Left</value-name>
            <value>$cardnvp{'Dim to Left'}</value>
      <name-and-value-authority/>
    </name>
    <name>
            <value-name>Dim to Front</value-name>
            <value>$cardnvp{'Dim to Front'}</value>
      <name-and-value-authority/>
    </name>
    <name>
            <value-name>Dim to Top</value-name>
            <value>$cardnvp{'Dim to Top'}</value>
      <name-and-value-authority/>
    </name>
    <label>
      <value-name/>
      <value/>
      <name-and-value-authority/>
    </label>
    <extension>
      <value-name/>
      <value/>
      <name-and-value-authority/>
    </extension>
    <operational-state>operational-state-disabled</operational-state>
    <administrative-control>administrative-control-quiescent</administrative-control>
    <administrative-state>administrative-state-locked</administrative-state>
    <lifecycle-state>lifecycle-state-installed</lifecycle-state>
  </spatial-properties-of-type>
  <manufactured-thing xmlns="urn:onf:params:xml:ns:yang:core-model">
    <equipment-instance>$cardnvp{'Part Number'}</equipment-instance>
    <manufacturer-properties>$cardnvp{'Manufacturer'}</manufacturer-properties>
    <equipment-type>$cardnvp{'Part Number'}</equipment-type>
    <operator-augmented-equipment-type/>
    <operator-augmented-equipment-instance/>
  </manufactured-thing>
 <equipment-type xmlns="urn:onf:params:xml:ns:yang:core-model">
    <model-identifier>$cardnvp{'Part Number'}</model-identifier>
    <zz:part-number>$cardnvp{'Part Number'}</zz:part-number>
    <zz:material-id>$cardnvp{'Material ID'}</zz:material-id>
    <zz:sap-code>$cardnvp{'SAP Code'}</zz:sap-code>
    <zz:clei-7>$cardnvp{'CLEI-7'}</zz:clei-7>
    <description>$cardnvp{'Description'}</description>
    <part-type-identifier/>
    <type-name/>
    <version/>
  </equipment-type>
  <equipment-instance xmlns="urn:onf:params:xml:ns:yang:core-model">
    <serial-number>$cardnvp{'Part Number'}</serial-number>
    <manufacture-date>16 July 2018</manufacture-date>
    <asset-instance-identifier/>
 </equipment-instance>

);

print $equipment;


