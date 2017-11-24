<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>

<xsl:strip-space elements="*"/>
<xsl:preserve-space elements=""/>

<xsl:template match="/">
<xsl:apply-templates select="VirtualMachine"/> 
</xsl:template>

<xsl:template match="/VirtualMachine">
<domain type='kvm'>
  <name><xsl:value-of select="metadata/name"/></name>
  <uuid><xsl:value-of select="metadata/uuid"/></uuid>
  <memory unit="KiB">
  <xsl:choose>
    <xsl:when test="spec/domain/memory/unit/text() = 'MB'">
      <xsl:value-of select="spec/domain/memory/value * 1024"/>
    </xsl:when>
  </xsl:choose>
  </memory>
  <vcpu>1</vcpu><!--fixme-->
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.3'><xsl:value-of select="spec/domain/os/type"/></type>
  </os>
  <features>
    <acpi/>
  </features>
  <cpu mode='max'>
    <model /><!--fixme-->
  </cpu>
  <devices>
    <xsl:apply-templates select="spec/domain/devices/disks"/>
    <xsl:apply-templates select="spec/domain/devices/interfaces"/>
    <xsl:apply-templates select="spec/domain/devices/graphics"/>
    <xsl:apply-templates select="spec/domain/devices/video"/>
  </devices>
</domain>
</xsl:template>

<xsl:template match="devices/video[type = 'qxl']">
<video>
  <model>
    <xsl:attribute name="type"><xsl:value-of select="./type"/></xsl:attribute>
  </model>
</video>
</xsl:template>

<xsl:template match="devices/graphics[type = 'spice']">
<graphics autoport="yes">
  <xsl:attribute name="type"><xsl:value-of select="./type"/></xsl:attribute>
  <listen type='address'/>
  <image compression='off'/>
</graphics>
</xsl:template>

<xsl:template match="devices/interfaces">
<interface type="user">
  <model>
    <xsl:attribute name="type"><xsl:value-of select="./model/type"/></xsl:attribute>
  </model>
</interface>
</xsl:template>

<xsl:template match="devices/disks[type = 'network']">
<disk type="network">
  <xsl:attribute name="device"><xsl:value-of select="./device"/></xsl:attribute>
  <driver>
    <xsl:attribute name="name"><xsl:value-of select="./driver/name"/></xsl:attribute>
    <xsl:attribute name="type"><xsl:value-of select="./driver/type"/></xsl:attribute>
  </driver>
  <source>
    <xsl:attribute name="protocol"><xsl:value-of select="./source/protocol"/></xsl:attribute>
    <xsl:attribute name="name"><xsl:value-of select="./source/name"/></xsl:attribute>
    <host>
      <xsl:attribute name="name"><xsl:value-of select="./source/host/name"/></xsl:attribute>
      <xsl:attribute name="port"><xsl:value-of select="./source/host/port"/></xsl:attribute>
    </host>
    <target>
      <xsl:attribute name="dev"><xsl:value-of select="./target/dev"/></xsl:attribute>
      <!--xsl:attribute name="bus"><xsl:value-of select="./target/bus"/></xsl:attribute-->
    </target>
  </source>
  <xsl:if test="./readonly[text() = 'True']"><readonly/></xsl:if>
  <xsl:if test="./transient[text() = 'True']"><transient/></xsl:if>
</disk>
</xsl:template>


</xsl:stylesheet>

