use strict;
use Data::UUID;

my $header = <STDIN>;
my $shelf = <STDIN>;
my %shelfnvp ;
print $header;
print $shelf;

my @headerp = split (",",$header);
my @shelfp = split (",",$shelf);

my $i;
for ($i=0;$i<$#headerp;$i++)
{
  printf "%s--%s\n", $headerp[$i],$shelfp[$i];
  $shelfnvp{$headerp[$i]} = $shelfp[$i];
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
    <manufactured-thing>$shelfnvp{'Part Number'}</manufactured-thing>
    <spatial-properties-of-type>$spatialuuid</spatial-properties-of-type>
    <mechanical-features/>
    <physical-properties/>
    <!--<function-enablers/>-->
    <mechanical-functions/>
    <physical-characteristics/>
    <swapability/>
    <structure>equipment-category-rack</structure>
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
      <value>$shelfnvp{'Template Name'}</value>
      <name-and-value-authority/>
    </name>
    <name>
      <value-name>Shelf AID Formula</value-name>
      <value><![CDATA[
               $shelfnvp{'Shelf AID Formula'}        
	       ]]></value>
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
          <height>$shelfnvp{'Height'}</height>
          <width>$shelfnvp{'Width'}</width>
          <length>$shelfnvp{'Depth'}</length>
    <local-id>
      <value-name/>
      <value/>
      <name-and-value-authority/>
    </local-id>
    <name>
            <value-name>weight</value-name>
            <value>$shelfnvp{'Weight'}</value>
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
    <equipment-instance>$shelfnvp{'Part Number'}</equipment-instance>
    <manufacturer-properties>CISCO</manufacturer-properties>
    <equipment-type>$shelfnvp{'Part Number'}</equipment-type>
    <operator-augmented-equipment-type/>
    <operator-augmented-equipment-instance/>
  </manufactured-thing>
 <equipment-type xmlns="urn:onf:params:xml:ns:yang:core-model">
    <model-identifier>$shelfnvp{'Part Number'}</model-identifier>
    <zz:part-number>$shelfnvp{'Part Number'}</zz:part-number>
    <zz:material-id>11321667</zz:material-id>
    <zz:sap-code>10780445</zz:sap-code>
    <zz:clei-7>WOML510</zz:clei-7>
    <description/>
    <part-type-identifier/>
    <type-name/>
    <version/>
  </equipment-type>
  <manufacturer-properties xmlns="urn:onf:params:xml:ns:yang:core-model">
    <manufacturer-identifier>CISCO</manufacturer-identifier>
    <manufacturer-name>CISCO</manufacturer-name>
  </manufacturer-properties>
);

print $equipment;


