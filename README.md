# テーブル設計

## users テーブル

| Column          | Type    | Options     |
| --------------- | ------  | ----------- |
| nickname        | string  | null: false |
| email           | string  | null: false |
| password        | string  | null: false |
| first_name      | string  | null: false |
| last_name       | string  | null: false |
| first_name_kana | string  | null: false |
| last_name-kana  | string  | null: false |
| birthday        | date    | null: false |

### Association

- has_many :items
- has_one :address
- has_one :orders

## items テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| name               | string     | null: false |
| picture            | image      | null: false |
| commnent           | string     | null: false |
| price              | integer    | null: false |
| category_id(activ) | integer    | null: false |
| status_id(activ)   | integer    | null: false |
| delivery_id(activ) | integer    | null: false |
| area_id(activ)     | integer    | null: false |
| day_id(activ)      | integer    | null: false |
| user_id(activ)     | integer    | null: false |


### Association

- belongs_to :user
- has_one :address
- has_one :orders

## addresses テーブル

| Column     | Type       | Options     |
| ---------- | ---------- | ----------- |
| post_code  | string     | null: false |
| pref       | string     | null: false |
| block      | string     | null: false |
| building   | string     | null: true  |
| tellphone  | string     | null: false |
| order_id   | integer    | null: false |

### Association

- belongs_to :item
- belongs_to :user

### orders テーブル

| Column     | Type       | Options     |
| item_id    | integer    | null: false |
| user_id    | integer    | null: false |

### Association

belongs_to :user
belongs_to :item