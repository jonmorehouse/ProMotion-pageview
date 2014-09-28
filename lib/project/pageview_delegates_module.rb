module ProMotion
  module PageViewDelegatesModule
    
    def pageViewController(pageview, viewControllerBeforeViewController:screen)
      previous_screen(screen)
    end

    def pageViewController(pageview, viewControllerAfterViewController:screen)
      next_screen(screen)
    end

    def presentationCountForPageViewController(pageview)
      return presentation_screen_index if respond_to?(:presentation_screen_index)
      0
    end

    def presentationIndexForPageViewController(pageview)
      return presentation_screen_index if respond_to?(:presentation_screen_index)
      0
    end

    def pageViewController(pageview, willTransitionToViewControllers:controllers)
      puts controllers.to_s
      
    end

    def pageViewController(pageview, didFinishAnimating:finished_animating, previousViewControllers:previous, transitionCompleted: transition_completed)

    end

    def pageViewController(pageview, spineLocationForInterfaceOrientation:spine)

      puts "spine location"
    end
  end
end
