module BAdapter.Shell (
    Shell (..)
    )
where
    import BAdapter
    import qualified Data.Text as T

    data Shell = Shell {name :: T.Text}

    instance IsAdapter Shell where
        hear x = name x
 