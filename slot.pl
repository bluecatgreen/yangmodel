#Physical Slot Name (Shelf Face Plate)--PWR TRAY 0 #
##Logical Slot Name (EMS/CLI)--PT0 #
##Slot Number--0 #
##Barcode Slot Position--F01 #
##Front/Rear--Front#
##Plane--
##Traffic Bearing (Y/N)--N#
##Slot Orientation (Vertical/Horizontal/Inverted)--Horizontal #
##Shelf Template Name--CS / NCS 4009 SHELF (NCS4009-SA-DC=) #
##Rack Template Name-- #
##Description--Power tray / PEM #
##Model--Power tray / PEM
##Height--2
##Width--16
##Depth--6
##Dim to Base--32
##Dim to Left--1.25
##Dim to Front--0
##Dim to Top--0
##Rel Order--0
##Parent Card Template Name--
##Subclass--LGHTWV
#
use strict;
use Data::UUID;

my $header = <STDIN>;
my @headerp = split (",",$header);
chop $header;
my %slotnvp ;
my $count = 0;
my $slot; 



my $ug = Data::UUID->new;
while (<STDIN>)
{
     $slot = $_;
     chop $slot;
     my @slotp = split (",",$slot);
     my $spatialuuid =  $ug->create_str();
     my $i;
     for ($i=0;$i<=$#headerp;$i++)
     {
       $slotnvp{$headerp[$i]} = $slotp[$i];
     }
     $count++;
     my $holder = qq  ( 
<holder xmlns="urn:onf:params:xml:ns:yang:core-model">
  <local-id>$count</local-id>
  <connector>
    <!-- # entries: 0.. -->
  </connector>
  <occupying-fru/>
  <spatial-properties-of-type>$spatialuuid</spatial-properties-of-type>
  <holder-monitor>
    <!-- # entries: 0.. -->
  </holder-monitor>
  <holder-location>
    <address-name/>
    <address-element>
      <uuid/>
      <address-element-name/>
      <local-id>
        <class-of-instance/>
        <local-id>
          <value-name/>
          <value/>
          <name-and-value-authority/>
        </local-id>
      </local-id>
      <name>
        <class-of-instance/>
        <name>
          <value-name>Side</value-name>
          <value>$slotnvp{'Front/Rear'}</value>
          <name-and-value-authority/>
        </name>
      </name>
      <arbitrary-element/>
    </address-element>
  </holder-location>
  <position>$slotnvp{'Slot Number'}</position>
  <holder-structure/>
  <environmental-rating/>
  <supported-equipment-type>
    <!-- # entries: 1.. -->
  </supported-equipment-type>
  <expected-holder/>
  <actual-holder/>
  <name>
    <value-name/>
    <value/>
    <name-and-value-authority/>
  </name>
  <name>
    <value-name>Shelf Face Plate</value-name>
    <value>$slotnvp{'Physical Slot Name (Shelf Face Plate)'}</value>
    <name-and-value-authority/>
  </name>
  <name>
    <value-name>CLI</value-name>
    <value>$slotnvp{'Logical Slot Name (EMS/CLI)'}</value>
    <name-and-value-authority/>
  </name>
  <name>
    <value-name>Barcode Slot Position</value-name>
    <value>$slotnvp{'Barcode Slot Position'}</value>
    <name-and-value-authority/>
  </name>
  <name>
    <value-name>Orientation</value-name>
    <value>$slotnvp{'Slot Orientation (Vertical/Horizontal/Inverted)'}</value>
    <name-and-value-authority/>
  </name>
  <name>
    <value-name>Description</value-name>
    <value>$slotnvp{'Description'}</value>
    <name-and-value-authority/>
  </name>
  <name>
    <value-name>Traffic Bearing</value-name>
    <value>$slotnvp{'Traffic Bearing (Y/N)'}</value>
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
</holder>
  <spatial-properties-of-type xmlns="urn:onf:params:xml:ns:yang:core-model">
          <uuid>$spatialuuid</uuid>
          <height>$slotnvp{'Height'}</height>
          <width>$slotnvp{'Width'}</width>
          <length>$slotnvp{'Depth'}</length>
    <local-id>
      <value-name/>
      <value/>
      <name-and-value-authority/>
    </local-id>
    <name>
            <value-name>weight</value-name>
            <value>$slotnvp{'Weight'}</value>
      <name-and-value-authority/>
    </name>
    <name>
            <value-name>Dim to Base</value-name>
            <value>$slotnvp{'Dim to Base'}</value>
      <name-and-value-authority/>
    </name>
    <name>
            <value-name>Dim to Left</value-name>
            <value>$slotnvp{'Dim to Left'}</value>
      <name-and-value-authority/>
    </name>
    <name>
            <value-name>Dim to Front</value-name>
            <value>$slotnvp{'Dim to Front'}</value>
      <name-and-value-authority/>
    </name>
    <name>
            <value-name>Dim to Top</value-name>
            <value>$slotnvp{'Dim to Top'}</value>
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
);

   print $holder;
} 
for (my $i=1;$i<=$count;$i++)
{
    my $holder = qq (<contained-holder>$i</contained-holder>
    );
    print "$holder";
}


