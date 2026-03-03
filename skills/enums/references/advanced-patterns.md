# Padrões Avançados com archtechx/enums

## Enum com Métodos Helper

```php
use ArchTech\Enums\{Metadata, Comparable, Options};
use ArchTech\Enums\Meta\Meta;

/**
 * @method string label()
 * @method string color()
 * @method string icon()
 * @method bool canTransitionTo()
 */
#[Meta(Label::class, Color::class, Icon::class)]
enum OrderStatus: int
{
    use Metadata, Comparable, Options;

    #[Label('Aguardando Pagamento')] #[Color('yellow')] #[Icon('clock')]
    case PENDING = 0;

    #[Label('Pago')] #[Color('blue')] #[Icon('credit-card')]
    case PAID = 1;

    #[Label('Processando')] #[Color('purple')] #[Icon('cog')]
    case PROCESSING = 2;

    #[Label('Enviado')] #[Color('indigo')] #[Icon('truck')]
    case SHIPPED = 3;

    #[Label('Entregue')] #[Color('green')] #[Icon('check-circle')]
    case DELIVERED = 4;

    #[Label('Cancelado')] #[Color('red')] #[Icon('times-circle')]
    case CANCELED = 5;

    #[Label('Reembolsado')] #[Color('gray')] #[Icon('undo')]
    case REFUNDED = 6;

    /**
     * Verifica se o pedido pode transitar para outro status
     */
    public function canTransitionTo(self $status): bool
    {
        return match ($this) {
            self::PENDING => in_array($status, [self::PAID, self::CANCELED]),
            self::PAID => in_array($status, [self::PROCESSING, self::REFUNDED]),
            self::PROCESSING => in_array($status, [self::SHIPPED]),
            self::SHIPPED => in_array($status, [self::DELIVERED]),
            self::DELIVERED => in_array($status, [self::REFUNDED]),
            default => false,
        };
    }

    /**
     * Retorna os próximos status possíveis
     */
    public function nextStatuses(): array
    {
        return collect(self::cases())
            ->filter(fn ($status) => $this->canTransitionTo($status))
            ->values()
            ->all();
    }

    /**
     * Verifica se é um status final
     */
    public function isFinal(): bool
    {
        return in_array($this, [self::DELIVERED, self::CANCELED, self::REFUNDED]);
    }

    /**
     * Retorna o progresso percentual
     */
    public function progress(): int
    {
        return match ($this) {
            self::PENDING => 10,
            self::PAID => 25,
            self::PROCESSING => 40,
            self::SHIPPED => 70,
            self::DELIVERED => 100,
            self::CANCELED, self::REFUNDED => 0,
        };
    }
}
```

## Enum Backed com String

```php
use ArchTech\Enums\{From, Options, Comparable};

enum SubscriptionPlan: string
{
    use From, Options, Comparable;

    case FREE = 'free';
    case BASIC = 'basic';
    case PRO = 'pro';
    case ENTERPRISE = 'enterprise';

    /**
     * Retorna o preço mensal em centavos
     */
    public function monthlyPrice(): int
    {
        return match ($this) {
            self::FREE => 0,
            self::BASIC => 990,      // R$ 9,90
            self::PRO => 2990,       // R$ 29,90
            self::ENTERPRISE => 9990, // R$ 99,90
        };
    }

    /**
     * Retorna o preço anual em centavos
     */
    public function yearlyPrice(): int
    {
        return (int) ($this->monthlyPrice() * 10); // 2 meses grátis
    }

    /**
     * Recursos disponíveis
     */
    public function features(): array
    {
        return match ($this) {
            self::FREE => [
                '5 projetos',
                '1 usuário',
                'Suporte por email',
            ],
            self::BASIC => [
                '20 projetos',
                '3 usuários',
                'Suporte prioritário',
                'API básica',
            ],
            self::PRO => [
                'Projetos ilimitados',
                '10 usuários',
                'Suporte dedicado',
                'API completa',
                'Webhooks',
                'SSO',
            ],
            self::ENTERPRISE => [
                'Tudo do PRO',
                'Usuários ilimitados',
                'SLA garantido',
                'Gerente de conta',
                'Customização',
                'On-premise option',
            ],
        };
    }

    /**
     * Verifica se tem um recurso específico
     */
    public function hasFeature(string $feature): bool
    {
        return str_contains(
            implode(' ', $this->features()),
            $feature
        );
    }

    /**
     * Limite de usuários
     */
    public function userLimit(): int
    {
        return match ($this) {
            self::FREE => 1,
            self::BASIC => 3,
            self::PRO => 10,
            self::ENTERPRISE => -1, // ilimitado
        };
    }

    /**
     * Se é ilimitado
     */
    public function isUnlimited(): bool
    {
        return $this->userLimit() === -1;
    }
}
```

## MetaProperties Avançadas

```php
<?php

namespace App\Enums\MetaProperties;

use ArchTech\Enums\Meta\MetaProperty;

#[Attribute]
class Label extends MetaProperty
{
    public static function method(): string
    {
        return 'label';
    }

    protected function transform(mixed $value): mixed
    {
        return $value;
    }

    public static function defaultValue(): mixed
    {
        return '';
    }
}

#[Attribute]
class Color extends MetaProperty
{
    public static function method(): string
    {
        return 'color';
    }

    protected function transform(mixed $value): mixed
    {
        // Transformar para classe Tailwind
        return "bg-{$value}-500 text-white";
    }

    public static function defaultValue(): mixed
    {
        return 'bg-gray-500 text-white';
    }
}

#[Attribute]
class Icon extends MetaProperty
{
    public static function method(): string
    {
        return 'icon';
    }

    protected function transform(mixed $value): mixed
    {
        // Adicionar prefixo Font Awesome
        return "fa-solid fa-{$value}";
    }

    public static function defaultValue(): mixed
    {
        return 'fa-solid fa-circle';
    }
}

#[Attribute]
class BadgeClass extends MetaProperty
{
    public static function method(): string
    {
        return 'badgeClass';
    }

    protected function transform(mixed $value): mixed
    {
        return "badge-{$value}";
    }

    public static function defaultValue(): mixed
    {
        return 'badge-neutral';
    }
}
```

## Testando Enums com Pest

```php
use App\Enums\OrderStatus;
use PHPUnit\Framework\TestCase;

test('order status transitions work correctly', function () {
    expect(OrderStatus::PENDING->canTransitionTo(OrderStatus::PAID))
        ->toBeTrue();

    expect(OrderStatus::PENDING->canTransitionTo(OrderStatus::DELIVERED))
        ->toBeFalse();

    expect(OrderStatus::DELIVERED->isFinal())
        ->toBeTrue();
});

test('order status returns correct progress', function () {
    expect(OrderStatus::PENDING->progress())
        ->toBe(10);

    expect(OrderStatus::DELIVERED->progress())
        ->toBe(100);
});

test('comparable trait works', function () {
    $status = OrderStatus::PENDING;

    expect($status->is(OrderStatus::PENDING))
        ->toBeTrue();

    expect($status->isNot(OrderStatus::PAID))
        ->toBeTrue();

    expect($status->in([OrderStatus::PENDING, OrderStatus::PAID]))
        ->toBeTrue();
});
```

## Factory com Enums

```php
use App\Enums\OrderStatus;
use App\Models\Order;

class OrderFactory extends Factory
{
    protected $model = Order::class;

    public function definition(): array
    {
        return [
            'status' => fake()->randomElement(OrderStatus::values()),
            'total' => fake()->numberBetween(1000, 100000),
        ];
    }

    public function pending(): self
    {
        return $this->state(fn () => [
            'status' => OrderStatus::PENDING,
        ]);
    }

    public function paid(): self
    {
        return $this->state(fn () => [
            'status' => OrderStatus::PAID,
        ]);
    }

    public function delivered(): self
    {
        return $this->state(fn () => [
            'status' => OrderStatus::DELIVERED,
        ]);
    }
}

// Uso em测试
Order::factory()->pending()->create();
Order::factory()->paid()->count(5)->create();
```

## Blade Component para Enum Select

```php
// app/View/Components/EnumSelect.php

namespace App\View\Components;

use Illuminate\View\Component;
use UnitEnum;

class EnumSelect extends Component
{
    public function __construct(
        public UnitEnum $enum,
        public string $name,
        public ?string $value = null,
        public string $id = null,
    ) {
        $this->id = $id ?? $name;
    }

    public function options(): array
    {
        if (method_exists($this->enum, 'options')) {
            return $this->enum::options();
        }

        return [];
    }

    public function render()
    {
        return view('components.enum-select');
    }
}
```

```blade
{{-- resources/views/components/enum-select.blade.php --}}
<select {{ $attributes->merge(['class' => 'select select-bordered', 'id' => $id, 'name' => $name]) }}>
    @foreach($options() as $name => $value)
        <option value="{{ $value }}" {{ $value == $old($name, $value) ? 'selected' : '' }}>
            {{ Str::headline($name) }}
        </option>
    @endforeach
</select>
```

```blade
{{-- Uso --}}
<x-enum-select :enum="OrderStatus::class" name="status" :value="$order->status" />
```

## Observer para Enums

```php
use App\Enums\OrderStatus;
use App\Models\Order;

class OrderObserver
{
    public function creating(Order $order): void
    {
        if ($order->status === null) {
            $order->status = OrderStatus::PENDING;
        }
    }

    public function updating(Order $order): void
    {
        if ($order->isDirty('status')) {
            $oldStatus = $order->getOriginal('status');
            $newStatus = $order->status;

            // Validar transição
            if (!$oldStatus->canTransitionTo($newStatus)) {
                throw new \InvalidArgumentException(
                    "Cannot transition from {$oldStatus->label()} to {$newStatus->label()}"
                );
            }

            // Log da transição
            OrderStatusTransition::create([
                'order_id' => $order->id,
                'from' => $oldStatus,
                'to' => $newStatus,
            ]);
        }
    }
}
```

## Query Scope com Enums

```php
use App\Enums\OrderStatus;
use Illuminate\Database\Eloquent\Builder;

class Order extends Model
{
    // ...

    public function scopeWithStatus(Builder $query, OrderStatus $status): Builder
    {
        return $query->where('status', $status->value);
    }

    public function scopeWithStatuses(Builder $query, array $statuses): Builder
    {
        return $query->whereIn('status', array_map(fn ($s) => $s->value, $statuses));
    }

    public function scopePending(Builder $query): Builder
    {
        return $this->withStatus(OrderStatus::PENDING);
    }

    public function scopeDelivered(Builder $query): Builder
    {
        return $this->withStatus(OrderStatus::DELIVERED);
    }

    public function scopeActive(Builder $query): Builder
    {
        return $this->withStatuses([
            OrderStatus::PAID,
            OrderStatus::PROCESSING,
            OrderStatus::SHIPPED,
        ]);
    }
}

// Uso
Order::pending()->get();
Order::active()->with('customer')->get();
```
