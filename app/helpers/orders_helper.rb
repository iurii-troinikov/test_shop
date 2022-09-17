module OrdersHelper
  DEFAULT_IMG_URL = 'https://s.dou.ua/CACHE/images/img/static/companies/Group_1_vAOIYxc/aa847aba009d54c7a09fc07f22fa6513.png'.freeze

  def status_badge(status)
    case status
    when 'in_progress'
      'bg-warning'
    when 'ordered'
      'bg-success'
    when 'canceled'
      'bg-secondary'
    else
      # type code here
    end
  end

  def order_images(order)
    product = order.products.detect { |product| product.images.attached? }

    if product.present?
      image_tag(product.images.first.variant(:thumbnail))
    else
      image_tag(DEFAULT_IMG_URL, width: 50, height: 50)
    end
  end
end
