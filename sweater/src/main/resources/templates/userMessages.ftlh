<#import "parts/commonTmpl.ftlh" as c>
<#import "parts/messageEditTmpl.ftlh" as m>
<#import "parts/messageListTmpl.ftlh" as l>

<@c.page>
    <#if isCurrentUser>
        <@m.edit true/>
    </#if>

    <@l.list true/>
</@c.page>