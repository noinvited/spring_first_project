<#import "parts/commonTmpl.ftlh" as c>
<#import "parts/messageEditTmpl.ftlh" as m>
<#import "parts/messageListTmpl.ftlh" as l>

<@c.page>
    <form method="get" action="/main" class="form-inline m-2">
        <label><input class="form-control mb-2 mr-sm-2" type="text" name="filter" value="${filter!}" placeholder="Введите тег"></label>
        <button type="submit" class="btn btn-primary ms-2">Найти</button>
    </form>

    <@m.edit false/>

    <@l.list false/>
</@c.page>