local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')

function AlomawaniUI.Description(order, name, width, fontSize)
    return {
        type = 'description',
        order = order,
        name = name,
        width = width,
        fontSize = fontSize,
    }
end

function AlomawaniUI.Spacer(order, fontSize)
    return {
        type = 'description',
        order = order,
        name = '',
        fontSize = fontSize,
    }
end

function AlomawaniUI.Header(order, name)
    return {
        order = order,
        type = 'header',
        name = name,
    }
end