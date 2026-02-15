#!/usr/bin/env php
<?php

/**
 * Script para criar um novo enum com archtechx/enums
 *
 * Uso: php scripts/make-enum.php PaymentStatus int
 *      php scripts/make-enum.php Role string
 */

if ($argc < 3) {
    echo "Uso: php make-enum.php <NomeDoEnum> <backingType> [pure]\n";
    echo "Exemplo: php make-enum.php PaymentStatus int\n";
    echo "         php make-enum.php Role string\n";
    echo "         php make-enum.php Color pure\n";
    exit(1);
}

$enumName = $argv[1];
$backingType = strtolower($argv[2]);
$usePure = isset($argv[3]) && strtolower($argv[3]) === 'pure';

// Validar backing type
if (!in_array($backingType, ['int', 'string', 'pure'])) {
    echo "Erro: backingType deve ser 'int', 'string' ou 'pure'\n";
    exit(1);
}

$namespace = 'App\\Enums';
$directory = 'app/Enums';

// Criar diretório se não existir
if (!is_dir($directory)) {
    mkdir($directory, 0755, true);
}

$fileName = "{$directory}/{$enumName}.php";

// Verificar se arquivo já existe
if (file_exists($fileName)) {
    echo "Erro: {$enumName} já existe em {$fileName}\n";
    exit(1);
}

// Gerar conteúdo do enum
$content = generateEnumContent($enumName, $backingType, $usePure);

// Escrever arquivo
file_put_contents($fileName, $content);

echo "✅ Enum {$enumName} criado em {$fileName}\n";
echo "⚠️  Não esqueça de:\n";
echo "   1. Adicionar os cases do enum\n";
echo "   2. Criar migration se necessário\n";
echo "   3. Adicionar cast no modelo se necessário\n";

function generateEnumContent(string $name, string $backingType, bool $usePure): string
{
    $traits = [
        'use ArchTech\\Enums\\Options;',
        'use ArchTech\\Enums\\Comparable;',
        'use ArchTech\\Enums\\From;',
    ];

    $usePure = $backingType === 'pure';
    $backingDeclaration = $usePure ? '' : ": " . ($backingType === 'string' ? 'string' : 'int');

    $phpdoc = generatePhpDoc();

    $traitsImploded = implode("\n    ", $traits);
    $uses = implode("\n", array_filter([
        "use ArchTech\\Enums\\Options;",
        "use ArchTech\\Enums\\Comparable;",
        $usePure ? "use ArchTech\\Enums\\From;" : "",
    ]));

    return <<<PHP
<?php

namespace App\\Enums;

{$uses}

{$phpdoc}
enum {$name}{$backingDeclaration}
{
    use Options, Comparable;

    // Adicione seus cases aqui
    // Exemplo:
    // case EXAMPLE = 1;
}
PHP;
}

function generatePhpDoc(): string
{
    return <<<DOC
/**
 * Enum {$name}
 *
 * @method static array options()
 * @method bool is(self \$other)
 * @method bool isNot(self \$other)
 * @method bool in(array \$others)
 * @method bool notIn(array \$others)
 */
DOC;
}
